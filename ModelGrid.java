package ResistanceSymmetric;

import HAL.GridsAndAgents.AgentGrid2D;
import HAL.GridsAndAgents.AgentSQ2D;
import HAL.GridsAndAgents.PDEGrid2D;
import HAL.Gui.GridWindow;
import HAL.Rand;
import HAL.Tools.FileIO;
import HAL.Util;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import static HAL.Util.*;
import static java.lang.Integer.parseInt;

class ModelCell extends AgentSQ2D<ModelGrid> { //the agents
    public int color;
    public void StepCel(){
        if (this.color ==GREEN){//S-cell (green) life cycle (Figure 2A in the manuscript)
            if (G.rng.Double() < (G.divProb + G.dieProb + G.alpha*G.dieProbD)/(1-G.moveProb)) {//Check if any event occur
                if (G.rng.Double() < (G.divProb + G.alpha*G.dieProbD) / (G.divProb + G.dieProb + G.alpha*G.dieProbD)) { //Decide whether natural death does not occur
                    if (G.rng.Double() < G.divProb / (G.divProb + G.alpha*G.dieProbD)){
                        int options = G.MapEmptyHoodK(G.divHood,Xsq(),Ysq());//Checking the available potions in the neighbourhood
                        if (options > 0) {
                            if (G.rng.Double() > G.dieProbD * G.GF.Get(Isq())) {//Decide whether does not die due to drug
                                int loc = G.rng.Int(options);//randomly choose where to put the new cell
                                if(G.PopAt(G.divHood[loc])<G.K ){
                                    if(G.rng.Double() > G.epsilon){// if mutation does not occur
                                        Dispose();  // Dispose the mother cell
                                        // Birth of two new daughter cells
                                        G.NewAgentSQ(Isq()).color = GREEN;
                                        G.NewAgentSQ(G.divHood[loc]).color= GREEN;
                                    }
                                    else{// if mutation occurs  //this.color = RED;
                                        Dispose();  // Dispose the mother cell
                                        // Birth of two new daughter cells
                                        G.NewAgentSQ(Isq()).color = RED;
                                        G.NewAgentSQ(G.divHood[loc]).color=RED;
                                    }
                                }
                            } else {
                                Dispose();
                            }
                        }
                    } else {
                        if(G.rng.Double() < (G.alpha *G.dieProbD*(1-G.p))/(G.alpha *G.dieProbD)){// if mutation is nonreversible
                            this.color = RED;
                        }
                        else{// if mutation is reversible
                            this.color = BLUE;
                        }
                    }
                } else {
                    Dispose();
                }
            }
        } else if (this.color ==RED){ //R-cell (red) life cycle (Figure 2C in the manuscript)
            if (G.rng.Double() < (G.divProbR + G.dieProb)/(1-G.moveProb)) {//Check if any event occur
                if (G.rng.Double() < G.divProbR / (G.divProbR + G.dieProb)) { //Decide whether natural death does not occur
                    int options = G.MapEmptyHoodK(G.divHood,Xsq(),Ysq());//Checking the available positions in the neighbourhood
                    if (options > 0) {
                        int loc = G.rng.Int(options);
                        if(G.PopAt(G.divHood[loc])<G.K ){
                            Dispose();// Dispose the mother cell
                            // Birth of two new daughter cells
                            G.NewAgentSQ(Isq()).color = RED;
                            G.NewAgentSQ(G.divHood[loc]).color = RED;
                        }
                    }
                } else {
                    Dispose();
                }
            }
        } else{ //P-cell (blue) life cycle (Figure 2B in the manuscript)
            if (G.rng.Double() < (G.divProbR + G.dieProb + (1-G.GF.Get(Isq()))*G.beta)/(1-G.moveProb)) {//Check if any event occur
                if (G.rng.Double() < (G.divProbR + (1-G.GF.Get(Isq()))*G.beta) / (G.divProbR + G.dieProb + (1-G.GF.Get(Isq()))*G.beta)) { //Decide whether natural death does not occur
                    if (G.rng.Double() <= G.divProbR / (G.divProbR + (1-G.GF.Get(Isq()))*G.beta)){// if divides
                        int options = G.MapEmptyHoodK(G.divHood,Xsq(),Ysq());//Checking the available positions in the neighbourhood
                        if (options > 0) {
                            int loc = G.rng.Int(options);
                            if(G.PopAt(G.divHood[loc])<G.K ){
                                Dispose();// Dispose the mother cell
                                // Birth of two new daughter cells
                                G.NewAgentSQ(Isq()).color = BLUE;
                                G.NewAgentSQ(G.divHood[loc]).color = BLUE;
                            }
                        }
                    } else { //reversion
                        this.color = GREEN;
                    }
                } else {
                    Dispose();
                }
            }
        }
    }
    public void StepCelFibro(){
        if (this.color ==GREEN){//S-cell (green) life cycle in fibroblast region
            if (G.rng.Double() < (G.divProbFibro + G.dieProbFibro + G.alphaFibro*G.dieProbDFibro)/(1-G.moveProb)) {//Check if any event occur
                if (G.rng.Double() < (G.divProbFibro + G.alphaFibro*G.dieProbDFibro) / (G.divProbFibro + G.dieProbFibro + G.alphaFibro*G.dieProbDFibro)) { //Decide whether natural death does not occur
                    if (G.rng.Double() < G.divProbFibro / (G.divProbFibro + G.alphaFibro*G.dieProbDFibro)){
                        int options = G.MapEmptyHoodK(G.divHood,Xsq(),Ysq());//Checking the available potions in the neighbourhood
                        if (options > 0) {
                            if (G.rng.Double() > G.dieProbDFibro * G.GF.Get(Isq())) {//Decide whether to dispose a cell
                                int loc = G.rng.Int(options);//randomly choose where to put the new cell
                                if(G.PopAt(G.divHood[loc])<G.K ){
                                    if(G.rng.Double() > G.epsilon){// if mutation does not occur
                                        Dispose();  // Dispose the mother cell
                                        // Birth of two new daughter cells
                                        G.NewAgentSQ(Isq()).color = GREEN;
                                        G.NewAgentSQ(G.divHood[loc]).color= GREEN;
                                    }
                                    else{// if mutation occurs  //this.color = RED;
                                        Dispose();  // Dispose the mother cell
                                        // Birth of two new daughter cells
                                        G.NewAgentSQ(Isq()).color = RED;
                                        G.NewAgentSQ(G.divHood[loc]).color=RED;
                                    }
                                }
                            } else {
                                Dispose();
                            }
                        }
                    } else {
                        if(G.rng.Double() < (G.alphaFibro *G.dieProbDFibro*(1-G.p))/(G.alphaFibro *G.dieProbDFibro)){// if mutation is nonreversible
                            this.color = RED;
                        }
                        else{// if mutation is reversible
                            this.color = BLUE;
                        }
                    }
                } else {
                    Dispose();
                }
            }
        } else if (this.color ==RED){ //R-cell (red) life cycle in fibroblast region
            if (G.rng.Double() < (G.divProbRFibro + G.dieProbFibro)/(1-G.moveProb)) {//Check if any event occur
                if (G.rng.Double() < G.divProbRFibro / (G.divProbRFibro + G.dieProbFibro)) { //Decide whether natural death does not occur
                    int options = G.MapEmptyHoodK(G.divHood,Xsq(),Ysq());//Checking the available positions in the neighbourhood
                    if (options > 0) {
                        int loc = G.rng.Int(options);
                        if(G.PopAt(G.divHood[loc])<G.K ){
                            Dispose();// Dispose the mother cell
                            // Birth of two new daughter cells
                            G.NewAgentSQ(Isq()).color = RED;
                            G.NewAgentSQ(G.divHood[loc]).color = RED;
                        }
                    }
                } else {
                    Dispose();
                }
            }
        } else{  //P-cell (blue) life cycle in fibroblast region
            if (G.rng.Double() < (G.divProbRFibro + G.dieProbFibro + (1-G.GF.Get(Isq()))*G.beta)/(1-G.moveProb)) {//Check if any event occur
                if (G.rng.Double() < (G.divProbRFibro + (1-G.GF.Get(Isq()))*G.beta) / (G.divProbRFibro + G.dieProbFibro + (1-G.GF.Get(Isq()))*G.beta)) { //Decide whether natural death does not occur
                    if (G.rng.Double() <= G.divProbRFibro / (G.divProbRFibro + (1-G.GF.Get(Isq()))*G.beta)){// if divides
                        int options = G.MapEmptyHoodK(G.divHood,Xsq(),Ysq());//Checking the available positions in the neighbourhood
                        if (options > 0) {
                            int loc = G.rng.Int(options);
                            if(G.PopAt(G.divHood[loc])<G.K ){
                                Dispose();// Dispose the mother cell
                                // Birth of two new daughter cells
                                G.NewAgentSQ(Isq()).color = BLUE;
                                G.NewAgentSQ(G.divHood[loc]).color = BLUE;
                            }
                        }
                    } else { //reversion
                        this.color = GREEN;
                    }
                } else {
                    Dispose();
                }
            }
        }
    }

    public void moveCel(){
        if (this.IsAlive()){
            //displaces the particle,
            int options = G.MapEmptyHoodK(G.divHood,Xsq(),Ysq());
            if (options>0){
                MoveSQ(G.divHood[G.rng.Int(options)]);
            }
        }
    }
}

public class ModelGrid extends AgentGrid2D<ModelCell> {//Grid to house the agents
    boolean dec, decOld; boolean AT = true; int N0, gCount, rCount, bCount, rs, K = 1;
    double divFibro = 1.0; double dieFibro = 1.0; double drugFibro = 1.0; double alpFibro = 1.0;
    double divProb = 0.027;//base growth rate
    double divProbR = (1-0.3)*divProb;
    double dieProb = 0.3*divProb;//constant death rate
    double dieProbD = 0.95;
    double moveProb = 1*divProb;
    double epsilon = 1e-4;//Probability of genetic mutation (epsilon) MPG
    double alpha = 1e-5;//Drug induced mutation probability (alpha) MPD
    double p = 0.9;//Probability of reversible drug induced mutation (p)
    double beta = 2*divProb;//0.9;//Reversion probability of RR-cells (beta) MPR
    double divProbFibro = divFibro*divProb;
    double divProbRFibro = divFibro*divProbR;
    double dieProbFibro = dieFibro*dieProb;
    double dieProbDFibro = drugFibro*dieProbD;
    double alphaFibro = alpFibro*alpha;

    public PDEGrid2D GF;//The PDEGrid2D to model the growth factor(GF) diffusion
    Rand rng = new Rand();// Define rng as a random number generator object
    int[]divHood= Util.VonNeumannHood(true);//RectangleHood(false,2,2);//

    public ModelGrid(int x, int y) {//Construct grid to house the agents
        super(x, y, ModelCell.class);
        GF = new PDEGrid2D(x,y);//Defining PDE grid
    }
    public int MapEmptyHoodK(int[] hood, int centerX, int centerY) {
        return MapHood(hood, centerX, centerY, (i, x, y) -> PopAt(i) < K );//GetAgent(i) == null
    }
    public void StepCells(){
        GF.Update();//Update the PDE solution
        ShuffleAgents(rng);//Shuffle the order of simulation
        for(ModelCell cell: this) {//Run the ABM for each cell
            if (rng.Double()>this.moveProb) {
                if (cell.Xsq()>600&&cell.Ysq()>100&&cell.Xsq()<801&&cell.Ysq()<901) { // FibroblastRegion
                    cell.StepCelFibro();
                }else{
                    cell.StepCel();
                }
            }else{
                cell.moveCel();
            }
        }
    }

    public void DrawModel(GridWindow win, int iPatch){//Drawing model
        //Black resembles absence of any cell
        for (int x = 0; x < xDim; x++) {//loop through all x
            for (int y = 0; y < yDim; y++) {//loop through all y
                if(GetAgent(x,y)!=null){
                    win.SetPix(x + iPatch * xDim,y,GetAgent(x,y).color);//win.SetPix(xDim+x,y,color);
                }else{
                    win.SetPix(x + iPatch * xDim,y, BLACK);
                }
            }

        }
    }
    public static void main(String[]args) {
        int x = 1000, y = 1000, timesteps = 15*365, nIter = 30; // Set time interval (timesteps), and number of realizations (nIter)
        int patchCount = 1; double redLevel = 2;

        GridWindow win = new GridWindow("Sensitive Cell(Green), Resistant cell(Red), Plastic cell(Blue)", x*patchCount, y, 1);//Define the display window
        for (int iIter = 0; iIter < nIter; iIter++) {
            double percentage = 0.1;
            ModelGrid[] model = new ModelGrid[patchCount];//Define the model

            for (int k = 1; k < 2; k++) {
                //initialize model//
                int ip = 0;
                    model[ip] = new ModelGrid(x, y);
                    //Initial cell configuration
                    String path = "C:/HAL-master/ResistanceSymmetric/input_x1000_t14000.csv"; //String path = "C:\\HAL-master\\210305\\"+ip+".csv";
                    int lineCount = 0;
                    model[ip].gCount = 0; model[ip].rCount = 0;
                    String line = "";
                    try {
                        BufferedReader br = new BufferedReader(new FileReader(path));
                        while ((line = br.readLine()) != null) {
                            String[] values = line.split(",");
                            for (int i = 0; i < values.length; i++) {
                                System.out.println(values[i]);
                                if (parseInt(values[i]) == 1) {
                                    model[ip].NewAgentSQ(lineCount * x + i).color = GREEN;
                                    model[ip].gCount++;
                                    System.out.println("G");
                                }
                                if (parseInt(values[i]) == 2) {
                                    model[ip].NewAgentSQ(lineCount * x + i).color = RED;
                                    model[ip].rCount++;
                                    System.out.println("R");
                                }
                            }
                            lineCount++;
                        }
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                model[ip].N0 = model[ip].Pop();//initial cell population
                model[0].dec = true;
                model[0].K = k;


                String filename = "AT_" + redLevel + "DrugDeath" + model[0].dieProbD + "_FC_" + model[0].divFibro + "_MPD_" + model[0].alpha + "_MPG_" + model[0].epsilon + "_MPR_" + model[0].beta + "_p_" + model[0].p + "_";

                FileIO popsOut = new FileIO(filename + "_" + iIter + ".csv", "w");
                popsOut.Write("divProbS" + "," + "divProbR" + "," + "dieProb" + "," + "moveProb" +  "," + "redLevel" + "\n");
                popsOut.Write(model[0].divProb + "," + model[0].divProbR + "," + model[0].dieProb + "," + model[0].moveProb + "," + redLevel + "\n");
                popsOut.Write(model[0].N0 + "," + model[0].rCount + "\n");//popsOut.Write(model[0].N0+","+model[0].rCount+","+model[1].N0+","+model[1].rCount+","+model[2].N0+","+model[2].rCount+","+ model[0].initPA +","+ model[0].initPA +","+ model[1].initPA +","+ model[2].initPA +"\n");
                popsOut.Write("Dose(1)" + "," + "Sensitive(1)" + "," + "Non-reversible(1)" + "," + "Reversible(1)" + "," + "Total(1)" + "\n");//popsOut.Write("Dose(1)" + "," + "Sensitive(1)" + "," + "Resistant(1)" + "," + "Total(1)" + "," + "Biomarker(1)" + "," + "Dose(2)" + "," + "Sensitive(2)" + "," + "Resistant(2)" + "," + "Total(2)" + "," + "Biomarker(2)" + "," + "Dose(3)" + "," + "Sensitive(3)" + "," + "Resistant(3)" + "," + "Total(3)" + "," + "Biomarker(3)" + "," + "Biomarker" + "\n");

                for (int i = 0; i < timesteps; i++) {
                    //Sets therapy
                    if (model[0].AT == false) {//Continuous Therapy
                        System.out.println(k + "" + model[0].dec + "0:" + i);
                        model[0].GF.SetAll(1);//
                        //}
                    } else {//Adaptive Therapy

                            if (model[ip].Pop() > model[ip].N0 / redLevel && model[ip].dec) {
                                model[ip].decOld = model[ip].dec;
                                model[ip].GF.SetAll(1);
                            } else if (model[ip].Pop() <= model[ip].N0 / redLevel) {
                                model[ip].decOld = model[ip].dec;
                                model[ip].dec = false;
                                model[ip].GF.SetAll(0);
                            } else if (model[ip].Pop() > model[ip].N0) {
                                model[ip].decOld = model[ip].dec;
                                model[ip].dec = true;
                            } else {
                                model[ip].decOld = model[ip].dec;
                                model[ip].GF.SetAll(0);
                            }
                            System.out.println(k + "" + model[ip].dec + ip + ":" + i);

                    }
                    double tPA = 0.0;
                    //Simulating the model over the time span
                        win.TickPause(100);
                        //model step
                        model[ip].StepCells();//Execute the model for each time step
                        //Count cell population
                        model[ip].rCount = 0;model[ip].bCount = 0;
                        for (int ix = 0; ix < model[ip].xDim; ix++) {
                            for (int iy = 0; iy < model[ip].yDim; iy++) {
                                if (model[ip].GetAgent(ix, iy) != null) {
                                    for (ModelCell cell : model[ip].IterAgents(ix, iy)) {//iterates over each agent in the grid point to count the number of all red cells in the grid
                                        if (cell.color == RED) {
                                            model[ip].rCount++;
                                        }
                                        if (cell.color == BLUE) {
                                            model[ip].bCount++;
                                        }
                                    }
                                }
                            }
                        }//Counting cell population ends
                        //draw
                        model[ip].DrawModel(win, ip);//Show the output

                        if ((i + 1) % 1000 == 0) { //saving cell configuration in csv file
                            FileIO distOut = new FileIO(filename + "_time_" + i + "_" + iIter + ".csv", "w");
                            percentage = percentage + 0.1;
                            for (int iy = 0; iy < model[ip].yDim; iy++) {
                                for (int ix = 0; ix < model[ip].xDim; ix++) {
                                    if (model[ip].GetAgent(ix, iy) != null) { //is there any cell in the site?
                                        if(model[ip].PopAt(ix,iy)==1){ //is the number of cells in the site is one?
                                            if (model[ip].GetAgent(ix, iy).color == GREEN) {
                                                distOut.Write("1");
                                            } else if (model[ip].GetAgent(ix, iy).color == RED) {
                                                distOut.Write("2");
                                            }
                                            else {
                                                distOut.Write("6");
                                            }
                                        } else{ //when the number of cells in the site more than one
                                            model[ip].rs = 0;
                                            for (ModelCell cell : model[ip].IterAgents(ix, iy)) {//iterates over each agent in the grid point to count the number of all red cells in the grid
                                                if (cell.color == RED) {
                                                    model[ip].rs++;
                                                }
                                            }
                                            if(model[ip].rs==0){
                                                distOut.Write("3");//Two sensitive cell
                                            }else if(model[ip].rs==1){
                                                distOut.Write("4");//One sensitive and one resistant cell
                                            }else{
                                                distOut.Write("5");//two resistant cell
                                            }
                                        }
                                    }else {
                                        distOut.Write("0");
                                    }
                                    if (ix < model[ip].xDim - 1) distOut.Write(",");
                                }
                                distOut.Write("\n");
                            }
                            distOut.Close();
                        }
                        //Save the temporal population data in csv file
                        popsOut.Write(model[ip].GF.GetAvg() + "," + (model[ip].Pop() - model[ip].rCount - model[ip].bCount) + "," + model[ip].rCount + "," + model[ip].bCount + "," + model[ip].Pop());
                        //System.out.println(rCount);            System.out.println(model.Pop()-rCount);

                    if ((i+1)%1000 == 0) {
                        win.ToPNG("C:\\HAL-master\\Day" + i + "_m_"+model[0].moveProb+"_AT.png"); //saving cell configuration as png image
                    }
                    popsOut.Write("\n");
                }
                popsOut.Close();
            }
        }
        win.Close();
    }

}
