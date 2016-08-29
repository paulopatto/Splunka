class BatchListRow extends React.Component {
  render () {
    let batch_path = (id) => "/sales_batches/"+id;
    return (
      <tr className='batch-list-item'>
        <td>
          <a href={batch_path(this.props.batch.id)}>
            <span className='glyphicon glyphicon-book'></span>
          </a>
        </td>

        <td>
          {this.props.batch.total_sales}
        </td>

        <td>
          R$ {this.props.batch.revenue}
        </td>

        <td>
          <p className='label label-info' title={this.props.batch.state}>
            {this.props.batch.state == 'resolved' ? "Concluído" : "A processar"}
          </p>
        </td>
      </tr>
    );
  }
}

