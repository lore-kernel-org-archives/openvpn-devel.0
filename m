Message-ID: <024f01c4438d$c50a1ac0$0100a8c0@...226...>
From: "Ming-Ching Tiew" <mingching.tiew@...225...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Trying to use zlib with openvpn
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
Date: Wed May 26 19:13:10 2004
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Last night after posting to openvpn-user maillist about
wanting to use zlib with OpenVPN, I had a look at the 
code. It seems the compression code is well-contained 
in lzo.c, I could even do a one-to-one swap of 
'LZO_COMPRESS' with zlib's 'compress' and similarly
for decompress. It get compiled and linked. I was quite
glad about that !!!

But of course, it is not so simple, it ran and crashed with
segmentation fault. I now suspect the decompression 
memory allocation is not big enough. Any clues
where else I should look at ?



  





