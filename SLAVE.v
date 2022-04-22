always @(posedge sck or negedge rstb)
  begin
    if (rstb==0)
        begin rreg = 8'h00;  rdata = 8'h00; done = 0; nb = 0; end   //
    else if (!ss) begin
            if(mlb==0) 
                begin rreg ={sdin,rreg[7:1]}; end
            else    
                begin rreg ={rreg[6:0],sdin}; end 
            nb=nb+1;
            if(nb!=8) done=0;
            else  begin rdata=rreg; done=1; nb=0; end
        end
  end

//send to  sdout
always @(negedge sck or negedge rstb)
  begin
    if (rstb==0)
        begin treg = 8'hFF; end
    else begin
        if(!ss) begin           
            if(nb==0) treg=tdata;
            else begin
               if(mlb==0)
                    begin treg = {1'b1,treg[7:1]}; end
               else 
                    begin treg = {treg[6:0],1'b1}; end           
            end
        end
     end 
  end 
