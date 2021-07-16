
<?php
global $sql_id;

function sql_connect() {
$sql_id=sqlsrv_connect('localhost', array(
			'Database' => 'zakupki',
			'UID' => 'sa',
			'PWD' => 'sa11011'));
     return $sql_id;
    };
function sql_escape($msg)
{
		return str_replace(array("'", "\0","«","»"), array('""', '',"*","*"), $msg);
}

function sql_close($id) { return sqlsrv_close($id); };
	function _sql_validate_value($var)
	{
		if (is_null($var))
		{ return 'NULL';}
		else if (is_string($var))
		{ return "'" . sql_escape($var) . "'";	}
		else
		{ return (is_bool($var)) ? intval($var) : $var; }
	}

?>
