class BatchListTable extends React.Component {


  render () {
    let createRow = (batch) => <BatchListRow key={batch.id} batch={batch} />;

    return (
      <table className='batch-list table table-striped'>
        <thead>
          <tr>
            <th> Lote </th>
            <th> Total de vendas </th>
            <th> Receita Bruta </th>
            <th> Status </th>
          </tr>
        </thead>

        <tbody>
          {this.props.batches.map(createRow)}
        </tbody>
      </table>
    );
  }
}

