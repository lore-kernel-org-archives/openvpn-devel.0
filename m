From: "Schlaffer Viktor" <schviktor@...277...>
MIME-Version: 1.0
Message-ID: <4451e733.3ac908e6.47ad.ffff9f05@...492...>
Subject: [Openvpn-devel] Overhead question
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
Date: Fri Apr 28 02:59:02 2006
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi!

I have a question about the overall overhead of OpenVPN. 
I'm using AES-128-CBC with lzo compression.
OpenVPN says these numbers during the init phase:

EF:58 - i think this is the actual overhead, without the tunnel. Is it
right?
EB:23 - this is an extra buffer for lzo?(can i reduce this somehow, without
turning lzo off???)
ET:0
EL:0

I found a picture about this on the internet, which is something like this:
----------------------------------------------------------------------------
--------------------------------------------------------------------
|eth 14b|IP 20b|UDP 8b||OpenVPN hdr ?b|Encrypted data(IP 20b,UDP8b,payload
xx b)|OpenVPN tlr|
----------------------------------------------------------------------------
--------------------------------------------------------------------

This shows nothing about HMAC, i think, that the actual packet looks like
this:
----------------------------------------------------------------------------
----------------------------------------------------------------------------
-
|IP 20b|UDP 8b| original packet IP+TCP 52 bytes | HMAC 20 b | IV ? B | seq
number 8b |encrypred DATA |
----------------------------------------------------------------------------
----------------------------------------------------------------------------
-

Here the actual overhead is 20+8+20+?+8 bytes. (IV 2 bytes?)
Is this correct? If not, can you explain me these 58 bytes reported by
OpenVPN?

Thanks in advance:
Viktor Schlaffer


