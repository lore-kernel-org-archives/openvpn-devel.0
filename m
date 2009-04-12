Message-ID: <508591.71590.qm@...1210...>
Date: Sun, 12 Apr 2009 16:10:26 -0700 (PDT)
From: Oana Comanici <oana.comanici@...109...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-743232443-1239577826=:71590"
Subject: [Openvpn-devel] Generating certificate/key pair locally on client
	machine
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0-743232443-1239577826=:71590
Content-Type: text/plain; charset=us-ascii

Hello, 

My name is Oana Comanici and I am developing a zero config application based on OpenVPN. I have encountered an issue regarding the generation of certificates for clients. Since the application is supposed to require as little configuration as possible, the actual method for generating the certificates on the server machine and copying them afterwards to the client is not appropriate. 

There are three possible solutions that I have found so far, but I don't know exactly which one is easier to implement and more efficient.

1. The clients could use self-signed SSL certificates for the communication with the server. At the moment, OpenVPN servers only accept connections from clients with certificates signed by the server's CA. However, it would decrease the level of security provided by the VPN.

2. The communication between client and server would be no longer based on certificates, but on a public key and a private key. Does the actual OpenVPN implementation offers any kind of support for this method?

3. The server acts as a CA, signing the Certificate Signing Request sent by the client. This would probably imply that the server was listening on a separate port for a .csr file from a file.

These are the solutions that I have thought of so far, but if there is a more efficient one, please tell me. Also, I would like to know which of the three ideas would be the best.

Thank you,
    Oana



      
--0-743232443-1239577826=:71590
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:verdana,helvetica,sans-serif;font-size:10pt">
<div style="font-family: verdana,helvetica,sans-serif; font-size: 10pt; color: rgb(0, 0, 0);"><div>Hello, <br><br>My name is Oana Comanici and I am developing a zero config application based on OpenVPN. I have encountered an issue regarding the generation of certificates for clients. Since the application is supposed to require as little configuration as possible, the actual method for generating the certificates on the server machine and copying them afterwards to the client is not appropriate. <br><br>There are three possible solutions that I have found so far, but I don't know exactly which one is easier to implement and more efficient.<br><br>1. The clients could use self-signed SSL certificates for the communication with the server. At the moment, OpenVPN servers only accept connections from clients with certificates signed by the server's CA. However, it would decrease the level of security provided by the VPN.<br><br>2. The communication between
 client and server would be no longer based on certificates, but on a public key and a private key. Does the actual OpenVPN implementation offers any kind of support for this method?<br><br>3. The server acts as a CA, signing the Certificate Signing Request sent by the client. This would probably imply that the server was listening on a separate port for a .csr file from a file.<br><br>These are the solutions that I have thought of so far, but if there is a more efficient one, please tell me. Also, I would like to know which of the three ideas would be the best.<br><br>Thank you,<br>&nbsp;&nbsp;&nbsp; Oana<br></div></div></div><br>



      </body></html>
--0-743232443-1239577826=:71590--


