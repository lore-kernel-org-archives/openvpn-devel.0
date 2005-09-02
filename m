From: Gervasio Bernal <gervasiobernal@...447...>
Message-ID: <loom.20050902T143928-990@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Protocol
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Sep  2 07:52:01 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

First of all, I will explain what we are trying to develop. Basically, our idea 
is to make OpenVPN works at kernel level, not at user level, and use the linux 
cryptoapi instead of openssl. We will not use de /dev/net/tun (that is user 
level space) and will create some new interfaces (something like openvpn0, 
openvpn1, etc.).  

We have being studying the OpenVPN source code but we get a little overwhelmed. 
It is not easy to understand all the sources. We need some help, especially to 
understand correctly the OpenVPN protocol. How the encrypted packet is formed? 
How the packet is desencrypted? If you add some extra data to the packet? etc, 
etc...
In a few words, we need the OpenVPN protocol.



We use this simple static-home.conf (Using Blowfish and SHA1 by default)
#################################################
# Sample OpenVPN configuration file for		
# home using a pre-shared static key.		
#						
# '#' or ';' may be used to delimit comments.	

dev tun
ifconfig 10.1.0.2 10.1.0.1
up ./client.up
secret static.key
port 5000
verb 3
#################################################




These are our doubts:
--------------------

1- In the web page (http://openvpn.net/security.html) it says:
"In static key mode, a pre-shared key is generated and shared between both 
OpenVPN peers before the tunnel is started. This static key contains 4 
independent keys: HMAC send, HMAC receive, encrypt, and decrypt. By default in 
static key mode, both hosts will use the same HMAC key and the same encrypt/
decrypt key. However, using the direction parameter to --secret, it is possible 
to use all 4 keys independently."

We genereted this static key:

# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
4fb804ced58655f5e0ab11d455477fec
4131d3ad3995d7d194ebc2d9bed39628
62f548089a5c485f3c0ef64aff5860a0
ad9c54ee9ec9e795e08b7b5118e5a8da
f2bc492fd3dd2f6cb94b3b0d62e324db
bcd662ef2127466ca08147ddb0326eb4
1f7c46dfa4c2dd766fb2e62eb76ef44c
75247095c87f1178942fb9e7a2917d31
75ac5d60ef8d25dcc72b4dc81df900f2
56fad6dc6c2341590db6fe126ce20fec
8be8a609b25fd8a45ec47045ef03971a
7858b4ff929a9822d636f4a3a1da343a
2c424958e4ef8526776c18f34aaf82b0
77f153221cb453467beb0d154b0f0ca6
f68e53bfb5f7f1d94496340c0010f319
d5e0619ee4b50fc0f129e1bbf76d3e8a
-----END OpenVPN Static key V1-----

Question: This is a 256 bytes key, which part of this key is used for HMAC and 
which for encryption/decryption? (We do not use de --secret option)




2- We test OpenVPN like this:

First we send a paquet without OpenVPN running. This is the structure of the 
packet we get with Ethereal. We use the following command: 
#echo "hola" | nc example.com 80

   Unencrypted Packet
   ------------------

  Total length=57 bytes
+-----------------------+ 		
|       IP HEADER    	|		IP Header length = 20 bytes	
|-----------------------|
|	TCP HEADER	      |		TCP Header length = 32 bytes	
|-----------------------|
|	DATA		      |		DATA length = 5 bytes
|		        	|
|	hola.	         	|
+-----------------------+




Then we start OpenVPN with this command: 
#openvpn --config static-home.conf --cipher none
We run:
#echo "hola" | nc 10.1.0.1 80
And we get this

OpenVPN Unencrypted Packet
--------------------------

Total length=113 bytes
+-----------------------+ 		
|       IP HEADER    	|		IP Header length = 20 bytes	
|-----------------------|
|	UDP HEADER	      |		UDP Header length = 8 bytes	
|-----------------------|
|  Original IP HEADER	|		Orig. IP Header length = 20 bytes
|-----------------------|
|  Original TCP HEADER	|		Orig. TCP Header length = 32 bytes
|-----------------------|
|	HMAC		      |		HMAC length = 20 bytes
|-----------------------|
|	IV		      |		IV length = ?????????
|-----------------------|
|   Sequence number	|		Sequence numbre length = 8 bytes
|-----------------------|
|	DATA		      |		DATA length = 5 bytes
|	hola.		      |
+-----------------------+

(http://openvpn.net/security.html)
"The plaintext of the encrypted envelope is formatted as follows:
64 bit sequence number
payload data, i.e. IP packet or Ethernet frame"

Question: What's the meaning of the sequence number field before the DATA? What 
contains?

Question: What length does the IV have? 
Question: Are correct the lengths we put? 
Question: Is correct the packet structure? 
Something must be wrong because if you add all the lengths (20 + 8 + 20 + 32 + 
20 + 8 + 5) you will get 113 (total packet length) but you did not add the IV 
length. 



And finally we restart OpenVPN with this command:
#openvpn --config static-home.conf 
We run:
#echo "hola" | nc 10.1.0.1 80
And we get this

OpenVPN Encrypted Packet
--------------------------

Total length=128 bytes
+-----------------------+ 		
|       IP HEADER    	|		IP Header length = 20 bytes	
|-----------------------|
|	UDP HEADER	      |		UDP Header length = 8 bytes	
|-----------------------|
|  Original IP HEADER	|		Orig. IP Header length = 20 bytes
|-----------------------|
|  Original TCP HEADER	|		Orig. TCP Header length = 32 bytes
|-----------------------|
|	HMAC		      |		HMAC length = 20 bytes
|-----------------------|
|	IV		      |		IV length = ?????????
|-----------------------|
|   Sequence number	|		Sequence numbre length = 8 bytes
|-----------------------|
|	DATA		      |		DATA length = 5 bytes
|	blabla		|
|-----------------------|
|	Rest		      |		Rest = 15??????? (Block cipher, Blowfish)
+-----------------------+

(http://openvpn.net/security.html)
"The plaintext of the encrypted envelope is formatted as follows:
64 bit sequence number
payload data, i.e. IP packet or Ethernet frame
The HMAC and explicit IV are outside of the encrypted envelope."

We supposed that the difference between the encrypted and desencryted packet 
lenght (15 bytes) is because we are using a block cipher (Blowfish - CBC).

Question: Is this correct? 
Question: The length of the sequence number plus the length of the payload must 
be an even multiple of block size?



We will apreciatte a lot your collaboration.

Gervasio Bernal, from Mendoza - Argentina
Pedro Deis, from Mendoza - Argentina



