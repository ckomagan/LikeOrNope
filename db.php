<?php

class db {

private static $instance ;
private $server = "" ;
private $user = "" ;
private $pass = "" ;
private $database = "" ;
private $link_id = 0;
private $query_id = 0 ;

/**
        Constructor
    **/
    private function __construct( $server=null, $user=null, $pass=null, $database=null ) 
	{
        $this->server = $server;
        $this->user = $user;
        $this->pass = $pass;
        $this->database = $database;
    }// END CONSTRUCTOR

/**
        Singleton Declaration
    **/
    public static function obtain() {
        if( !self::$instance) {
            self::$instance = new db( "komagancom.fatcowmysql.com", "tindertraveler", "tr@v3l3r", "tindertraveler" ) ;
        }
        return self::$instance ;
    }// END SINGLETON DECARATION

	
public function connect($link=false)
	{
		$this->link_id = mysql_connect($this->server, $this->user, $this->pass, $link);
		if( !$this->link_id) {
            echo "Could not connect to the MySQL Database Server: <b>$this->server</b>." ;
        }
 
        if( !@mysql_select_db( $this->database, $this->link_id ) ) {
            echo "Could not open database: <b>$this->database</b>." ;
        }
 
        // Reset connection data so it cannot be dumped
        $this->server = "" ;
        $this->user = "" ;
        $this->pass = "" ;
        $this->database = "" ;
    }

	/**
        Close the connection to the database
    **/
    public function close( ) {
        if( !@mysql_close( $this->link_id ) ) {
            echo "Connection close failed!" ;
        }
    }// END CLOSE

	 /**
        Escapes characters to be mysql ready
    **/
    public function escape( $string ) {
        if( get_magic_quotes_runtime( ) ) $string = stripslashes( $string ) ;
        return @mysql_real_escape_string( $string, $this->link_id ) ;
    }// END ESCAPE
    
    public function query( $sql ) {
 		$result = @mysql_query($sql, $this->link_id) or die(mysql_error());
		return $result; 
	}

	    /**
        Execute an insert query with an array
    **/
    public function insert( $table, $data ) {
        $q="INSERT INTO `$table` ";
        $v=''; $n='';
		print_r($data);
		    foreach($data as $key=>$val){
            $n.="`$key`, ";
			if(strtolower($val)=='null') $v.="NULL, ";
            elseif(strtolower($val)=='now()') $v.="NOW(), ";
            else $v.= "'".$this->escape($val)."', ";
			//echo $v;
        }
 
  		$q .= "VALUES (". rtrim($v, ', ') .");";
 
        return @mysql_query($q, $this->link_id) or die(mysql_error());
    }// END INSERT

	/**
        Execute an update query with an array
    **/
    public function update( $table, $data, $where='1', $symbol ) {
        $q = "UPDATE `$table` SET " ;
		$q.= $data.' WHERE '.$where. ' = "' . $symbol.'" ;' ;
		//print_r($q);
    	return @mysql_query($q, $this->link_id) or die(mysql_error());
	
    }// END UPDATE

	public function getRandomQuestion( $question_id ) {
		
		$sql = "select question_text from questions where question_id = ".$question_id;
		//print_r($sql);
		$question = $this->query( $sql );
		return mysql_result($question, 0);
	}
	
	public function checkUser($fbId) {
			$sql = "select * from Profile where fbId = '".$fbId."';";
			//print($sql);
			$result = $this->query( $sql );
			$thisrow = mysql_fetch_row($result);
			$res = array();
			if ($thisrow)  //if the results of the query are not null
			{
			  //print("fbID already exists, select another!");
			  $row_array['result'] = "1";
			  array_push($res, $row_array);
			  return $res;
			}
			else {
			  $row_array['result'] = "0";
			  array_push($res, $row_array);
			  return $res;				
			  }
	}
	
	public function addNewUser($data) {
		$q="INSERT INTO Profile ";
        $v=''; $n='';
		//print_r($data);
		foreach($data as $key=>$val){
            $n.="`$key`, ";
			if(strtolower($val)=='null') $v.="NULL, ";
            elseif(strtolower($val)=='now()') $v.="NOW(), ";
            else $v.= "'".$this->escape($val)."', ";
			//echo $v;
        }
        $v.= 'NOW()';
  		$q .= "VALUES (". rtrim($v, ', ') . ");";
 		print_r($q);
        @mysql_query($q, $this->link_id) or die(mysql_error());
        return @mysql_insert_id();
	}
	
	public function addNewGoal($data) {
		$q="INSERT INTO Goals ";
        $v=''; $n='';
		//print_r($data);
		foreach($data as $key=>$val){
            $n.="`$key`, ";
			if(strtolower($val)=='null') $v.="NULL, ";
            elseif(strtolower($val)=='now()') $v.="NOW(), ";
            else $v.= "'".$this->escape($val)."', ";
			//echo $v;
        }
  		$q .= "VALUES (". rtrim($v, ', ') . ");";
 		print_r($q);
        @mysql_query($q, $this->link_id) or die(mysql_error());
        return @mysql_insert_id();
	}
	
	public function getGoalCount( $fbId) {
		
		$potentialMatches = array();
		$matchCount = 0;
		$sql = "SELECT count(*) FROM `Goals` WHERE (fbId= ". $fbId .")";
		
		//print_r($sql);
		$matches = $this->query( $sql );
		while($row = mysql_fetch_array($matches))
		{
			$matchCount = $row[0];
		}
		//print_r ($matchCount);
		return $matchCount;
	}
	
	public function addToLikeList($data) {
		$q="INSERT INTO Liked ";
        $v=''; $n='';
		//print_r($data);
		foreach($data as $key=>$val){
            $n.="`$key`, ";
			if(strtolower($val)=='null') $v.="NULL, ";
            elseif(strtolower($val)=='now()') $v.="NOW(), ";
            else $v.= "'".$this->escape($val)."', ";
			//echo $v;
        }
  		$q .= "VALUES ('',". rtrim($v, ', ') . ");";
 		//print_r($q);
        @mysql_query($q, $this->link_id) or die(mysql_error());
        return @mysql_insert_id();
	}
	
	public function addToNopeList($data) {
		$q="INSERT INTO Noped ";
        $v=''; $n='';
		print_r($data);
		foreach($data as $key=>$val){
            $n.="`$key`, ";
			if(strtolower($val)=='null') $v.="NULL, ";
            elseif(strtolower($val)=='now()') $v.="NOW(), ";
            else $v.= "'".$this->escape($val)."', ";
			//echo $v;
        }
  		$q .= "VALUES ('',". rtrim($v, ', ') . ");";
 		print_r($q);
        @mysql_query($q, $this->link_id) or die(mysql_error());
        return @mysql_insert_id();
	}
	
	public function isMutualMatch($fbId, $likefbId) {
		$q = "select count(*) from Liked where ((fbId= ". $fbId .") and (likefbId = ". $likefbId . ")) or ((fbId = ". $likefbId . ") and (likefbId = ". $fbId . "))";
		//echo $q;
		$matches = $this->query( $q );
		while($row = mysql_fetch_array($matches))
		{
			$mutualMatch = $row[0];
		}
		//echo "mutual match = ". $mutualMatch; 
		return $mutualMatch;
	}
	
	public function findMatches( $fbId ) {
		$potentialMatches = array();
		$myList = $this->getMyBucketList( $fbId );
		
		foreach($myList as $list)
		{
			foreach($list as $key => $val) 
			{
    			//print "$key = $val\n";
			}
			
			$sql = "SELECT * FROM `Goals` WHERE (fbId != '". $fbId . "' AND CITY= '" .$list['city']. "' AND DATE(fromDate) between Date('". $list['fromDate'] ."') and Date('". $list['toDate'] ."')) OR (fbId != '". $fbId . "' AND CITY='" .$list['city']. "' AND DATE(toDate) between Date('". $list['fromDate'] . "') and Date('". $list['toDate'] . "'))";
				//print_r($sql);
				
				$matches = $this->query( $sql );
				while($row = mysql_fetch_array($matches))
				{
					$row_array['fbId'] = $fbId;
					
					$profileSql = "select * from Profile where fbId = '". $row['fbId'] ."';";
					//print_r($profileSql);

					$profileData = $this->query( $profileSql );
					while($row2 = mysql_fetch_array($profileData))
					{
						$row_array['matchfbId'] = $row2['fbId'];
						$row_array['name'] = $row2['name'];
						$row_array['emailId'] = $row2['emailId'];
						$row_array['location'] = $row2['location'];
						$row_array['zip'] = $row2['zip'];
						$row_array['age'] = $row2['age'];
						$row_array['gender'] = $row2['gender'];
						$row_array['mainphoto'] = $row2['mainphoto'];
					}
					$row_array['travelcity'] = $row['city'];
					$row_array['travelcountry'] = $row['country'];
					$myDate = new DateTime($row['fromDate']);
					$row_array['fromDate'] = $myDate->format('M d, Y');
					$myDate = new DateTime($row['toDate']);
					$row_array['toDate'] = $myDate->format('M d, Y');
					array_push($potentialMatches, $row_array);
				}
		}
		print_r ($potentialMatches);
		return $potentialMatches;
	}
	
	public function findMatchCount( $id, $city, $country, $fromDate, $toDate ) {
		
		$potentialMatches = array();
		$matchCount = 0;
		$sql = "SELECT count(*) FROM `Goals` WHERE (ID != '". $id . "' AND CITY= '" .$city. "' AND DATE(fromDate) between Date('". $fromDate ."') and Date('". $toDate ."')) OR (ID != '". $id . "' AND CITY='" .$city. "' AND DATE(toDate) between Date('". $fromDate . "') and Date('". $toDate. "'))";
		
		print_r($sql);
		$matches = $this->query( $sql );
		while($row = mysql_fetch_array($matches))
		{
			//$answers =  array();
			$matchCount = $row[0];
		}
		print_r ($matchCount);
		return $matchCount;
	}
	
	/* Retrieve logged in user's bucket list */
	public function getMyBucketList( $fbId )
	{
		$myBucketList = array();
		
		$sql = "SELECT * FROM `Goals` WHERE fbId = ". $fbId;
		
		//print_r($sql);
		$list = $this->query( $sql );
		while($row = mysql_fetch_array($list))
		{
			$row_array['goal'] = $row['goal'];
			$row_array['city'] = $row['city'];
			$row_array['country'] = $row['country'];
			$row_array['fromDate'] = $row['fromDate'];
			$row_array['toDate'] = $row['toDate'];
			array_push($myBucketList, $row_array);
		}
		//print_r ($myBucketList);
		return $myBucketList;
	}
}

?>