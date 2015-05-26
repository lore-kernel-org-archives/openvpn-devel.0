Message-ID: <5564CEF6.1080302@...1856...>
Date: Tue, 26 May 2015 21:52:22 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <55619DC4.2020108@...1856...> <5562310A.1040108@...1147...>
	<556238FD.5040202@...1856...> <55649471.9070105@...1147...>
In-Reply-To: <55649471.9070105@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Clarify --capath option in manpage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>


On 26-05-15 17:42, Jan Just Keijser wrote:
> So, ACK to the patch afterall, although we could discuss whether

Thanks for the clarification. Let's discuss!

> a) we want to support stacked CRLs (does PolarSSL support this?)

I'll assume that 'stacked CRLs' means multiple (PEM?) CRLs concatenated 
into a single file.

Both OpenSSL and PolarSSL are capable of dealing with this, but we 
currently don't really use the crypto library CRL checking code for 
--crl-verify.  Instead, we have our own x509_verify_crl() function that 
loads and checks the supplied CRL on every connect.  Our implementation 
of that function does not support stacked CRLs in both our OpenSSL and 
PolarSSL builds.

The real solution here is probably to let the crypto library do the CRL 
handling.  Adriaan actually started on that during the latest Munich 
hackathon, but ended up in a bathtub rather quickly [0].  I had a 
similar experience a little longer ago.  The tricky part, iirc, is to 
figure out when en how to reload the CRL.  But we probably both did not 
truly take the time to 'dive in' ;)

> b) we want to support --capath *without* CRLs (relatively short patch).

Yes, I considered that too, but decided not to propose it and see if 
anyone else would suggest it.  So thank you ;)  Perhaps a 
--crl-soft-fail option?  The other side of that knife would be that we 
can introduce stricter CRL checking for --crl-verify too.  For example,
our current implementation of x509_verify_crl() will happily accept 
clients if you supply the wrong CRL (but fail if you supply an invalid 
CRL).  That strikes me as weird.  Most clients I know of resolve that by 
implementing their own CRL checking on some plugin or script.

I don't run large OpenVPN setups myself, so I am very much interested to 
know how 'enterprise users' of OpenVPN deal with this kind of thing, and 
what they would like.

-Steffan

[0] 
http://img.pandawhale.com/post-10513-Code-Refactoring-Cat-in-Bathtu-U295.gif

