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

}