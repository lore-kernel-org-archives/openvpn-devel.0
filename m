From: chantra <chantra@...1258...>
Content-Type: multipart/alternative; boundary="=-uJ2DL5Bkzzg++KJGNTXr"
Date: Mon, 31 May 2010 19:59:04 +0200
Message-ID: <1275328744.23148.747.camel@...1259...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Handling of subnets grammar in Packet filter file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-uJ2DL5Bkzzg++KJGNTXr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi all,

It seems that openvpn is not handling properly non-standard subnets in
pf_file.
This issue happened on debian etch openvpn 2.1 rc11

Today, while I made a typo, the following rule did not work properly:

        # cat /dev/shm/openvpn_pf_73f2c3256a50371f057d5c0db97ede2f.tmp
        [CLIENTS DROP]
        
        [SUBNETS ACCEPT]
        +192.168.100.0/29
        -192.168.100.8/28
        
        [END]
        

-192.168.100.8/28 was simply ignored which basically allowed the client
to ping the whole subnet

The following rule behaved properly though.

        # cat /dev/shm/openvpn_pf_f2b43d3cb1acd5a2720c01559cb03dc3.tmp
        [CLIENTS DROP]
        
        [SUBNETS ACCEPT]
        +192.168.100.0/29
        -192.168.100.0/28
        [END]
        

I agree it is not a really bug as it is a user error in the first place
and openvpn carried on happily discarding this rule.
But maybe openvpn could try to handle such subnets and translate it as
192.168.100.0/8.

I could try to look into it if you guys believe it should be handled by
openvpn (or maybe this has already been fixed?)

Regards,

chantra



!DSPAM:4c03f8ea61674059325257!

--=-uJ2DL5Bkzzg++KJGNTXr
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
Hi all,<BR>
<BR>
It seems that openvpn is not handling properly non-standard subnets in pf_file.<BR>
This issue happened on debian etch openvpn 2.1 rc11<BR>
<BR>
Today, while I made a typo, the following rule did not work properly:<BR>
<BLOCKQUOTE>
    # cat /dev/shm/openvpn_pf_73f2c3256a50371f057d5c0db97ede2f.tmp<BR>
    [CLIENTS DROP]<BR>
    <BR>
    [SUBNETS ACCEPT]<BR>
    +192.168.100.0/29<BR>
    -192.168.100.8/28<BR>
    <BR>
    [END]<BR>
    <BR>
</BLOCKQUOTE>
-192.168.100.8/28 was simply ignored which basically allowed the client to ping the whole subnet<BR>
<BR>
The following rule behaved properly though.<BR>
<BLOCKQUOTE>
    # cat /dev/shm/openvpn_pf_f2b43d3cb1acd5a2720c01559cb03dc3.tmp<BR>
    [CLIENTS DROP]<BR>
    <BR>
    [SUBNETS ACCEPT]<BR>
    +192.168.100.0/29<BR>
    -192.168.100.0/28<BR>
    [END]<BR>
    <BR>
</BLOCKQUOTE>
I agree it is not a really bug as it is a user error in the first place and openvpn carried on happily discarding this rule.<BR>
But maybe openvpn could try to handle such subnets and translate it as 192.168.100.0/8.<BR>
<BR>
I could try to look into it if you guys believe it should be handled by openvpn (or maybe this has already been fixed?)<BR>
<BR>
Regards,<BR>
<BR>
chantra<BR>
<BR>

!DSPAM:4c03f8ea61674059325257!

</BODY>
</HTML>



--=-uJ2DL5Bkzzg++KJGNTXr--



