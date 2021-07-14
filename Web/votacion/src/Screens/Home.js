import react, {useState} from 'react';
import Chart from "react-google-charts";

export default function Home() {
  const [votesBrasil, setVotesBrasil] = useState(4)
  const [votesArgentina, setVotesArgentina] = useState(8)
  const data = [['Votos','asd(asd)'],['Argentina',votesArgentina],['Brasil',votesBrasil]]

  return(
    <div style={{paddingLeft:'90px',paddingTop:'90px',border:'1 px solid #000'}}>
      <button onClick={()=>{setVotesBrasil(votesBrasil+1)}}>Votar para brasil</button>
      <button onClick={()=>{setVotesArgentina(votesArgentina+1)}}>Votar para argentina</button>
      <p>{votesBrasil} Brasil</p>
      <p>{votesArgentina} Argentina</p>
      {/* <Doughnut data={data} options={options}/> */}
      <Chart
        width={'500px'}
        height={'300px'}
        chartType="PieChart"
        loader={<div>Loading Chart</div>}
        data={
          data
        }
        options={{
          title: 'Votacion',
        }}
        rootProps={{ 'data-testid': '1' }}
      />
    </div>
  );
}
