Message-ID: <4E7A4D82.7060603@...41...>
Date: Wed, 21 Sep 2011 14:48:02 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN and BEAST
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

We've gotten some questions about whether OpenVPN is vulnerable to the 
"BEAST" exploit.

At the time of this writing, the details of the "BEAST" exploit haven't 
been released yet, but the general consensus is that it exploits the 
known-IV weakness in SSL and TLS 1.0 that is discussed by Bard back in 2004:

http://eprint.iacr.org/2004/111.pdf

The vulnerability is present in all versions of SSL and TLS 1.0 but not 
TLS 1.1 or higher (OpenVPN currently uses TLS 1.0).

One of the common workarounds for this vulnerability is to have the SSL 
implementation add empty fragments into the application data stream. 
OpenSSL has implemented this workaround since 0.9.6d (9 May 2002).

See http://www.openssl.org/~bodo/tls-cbc.txt

So the bottom line is that even though OpenVPN uses TLS 1.0 which is 
technically vulnerable, the OpenSSL workaround added in 0.9.6d 
effectively protects TLS 1.0 from this vulnerability, and hence OpenVPN 
as well.

Now if OpenSSL patched this back in 2002, you might be wondering why 
it's an exploitable vulnerability today.  I think the answer is that 
while OpenSSL patched the vulnerability, NSS did not (NSS is an 
alternative to OpenSSL that is widely used in web browsers).

In fact, if you look at this recent commit to NSS by the Chromium 
project (presumably to address the BEAST exploit), you see the same 
workaround being added to NSS that was added to OpenSSL 9 years ago.

https://src.chromium.org/viewvc/chrome?view=rev&revision=90643

James

