class Edge{

    Vertex v0;
    Vertex v1;

    Edge(Vertex v0 ,Vertex v1){
        this.v0 = v0;
        this.v1 = v1;
    }

    void draw(){
        println(" x1 :"+ v0.vertex.x + " y1 :" +
        v0.vertex.y +  "z1 :" + v0.vertex.z + " x2 :"+ v1.vertex.x+" y2 :"+
         v1.vertex.y+" z2 :"+ v1.vertex.z);
        stroke(255);
        line(v0.vertex.x,v0.vertex.y,v0.vertex.z , v1.vertex.x, v1.vertex.y, v1.vertex.z);
    }

    PVector midPoint(){
        PVector vmid = PVector.add(v0.vertex, v1.vertex);
        return vmid.div(2);
    }

}

class Vertex{

    PVector vertex;

    Vertex(float i, float j, float k, float s){
        
        vertex = new PVector(i*s, j*s, k*s);

    }

}