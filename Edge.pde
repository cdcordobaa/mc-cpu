class Edge{

    Vertex v0;
    Vertex v1;

    Edge(Vertex v0 ,Vertex v1){
        this.v0 = v0;
        this.v1 = v1;
    }

    void draw(){

        line(v0.vertex.x,v0.vertex.y,v0.vertex.z , v1.vertex.x, v1.vertex.y, v1.vertex.z);
    }

    PVector midPoint(){
        PVector vmid = PVector.add(v0.vertex, v1.vertex);
        return vmid.div(2);
    }

    PVector linearInterpolation(float isolevel){

        //P = v0.vertex + (isovalue - V1) (v1.vertex - v0.vertex) / (V2 - V1) 

        float mu;        
        PVector p = new PVector();

        if (abs(isolevel-v0.isoValue) < 0.00001)
            return(v0.vertex);
        if (abs(isolevel-v1.isoValue) < 0.00001)
            return(v1.vertex);
        if (abs(v0.isoValue-v1.isoValue) < 0.00001)
            return(v0.vertex);

        mu = (isolevel - v0.isoValue) / (v1.isoValue - v0.isoValue);
        p.x = v0.vertex.x + mu * (v1.vertex.x - v0.vertex.x);
        p.y = v0.vertex.y + mu * (v1.vertex.y - v0.vertex.y);
        p.z = v0.vertex.z + mu * (v1.vertex.z - v0.vertex.z);

        return(p);

    }

}

class Vertex{

    PVector vertex;
    float isoValue = 0;

    Vertex(float i, float j, float k){

        vertex = new PVector(i, j, k);

    }

    void setIsovalue(float isoValue){
        this.isoValue = isoValue;
    }

    float getIsovalue(){
        return isoValue;
    }

    void setIsovalueFromPoint(PVector point, float weight, float scale){
        float dist = max(1.0f, point.dist(vertex));
        isoValue += (1.0f /  pow(dist,2))*weight*scale*scale;        
    }

}