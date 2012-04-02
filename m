Message-ID: <4F7981C4.80409@...1114...>
Date: Mon, 02 Apr 2012 12:39:00 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
	<CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
	<4F797A66.8050502@...1114...>
	<CAOazyz0uhi_ao2SN3Moi+tXRVhaJPd-O1eam0tqLo_6rehVREg@...278...>
In-Reply-To: <CAOazyz0uhi_ao2SN3Moi+tXRVhaJPd-O1eam0tqLo_6rehVREg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
 RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/04/12 12:25, Alon Bar-Lev wrote:
> No no no.... I did not imply that this will be dynamic interface. 
> Nor that there is a use case.
> 
> The current state of the code (even before the merge of polarssl)
> was very complex. Now it is even more complex, with none
> clean/strict separation between the common crypto code and the
> library specific crypto code... Yes, I know these resides in
> different sources, but it is more similar to what we call
> "spaghetti" programming.
> 
> What I suggest of doing is to create static callback structure
> which is the interface of crypto library used by openvpn. This is
> *STATIC* linkage.
> 
> For example: typedef struct { result_t (*x509_get_username) (char
> *cn, int cn_len, char *x509_username_field, x509_cert *cert) ... }
> openvpn_crypto_enigne_t;
> 
> I guess you understand how this struct will look like.
> 
> Now, a nice side effect would be the ability to have both
> libraries linked against openvpn, while choosing the engine at
> configuration... Of course there is no real world use for this,
> except for build (one build checks both libraries) and test (we can
> use test one build for both).
> 
> The main mission is to clean up the code, reducing the complexity, 
> making sure we can follow each crypto call to either common, 
> crypto-library-atom, or openvpn specific.
> 
> Is that more clear?

Ahh, yeah!  That makes more sense.

But I just need to be sure we're having the right focus.  Are we
getting done with the autotools clean-up?  If not, what's missing?  I
see more and more clean-up patches touching the C code now, so I just
want to be sure we're basically done with autotools.  Otherwise,
getting rid of syshead.h is probably one of the next bigger steps.


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95gcAACgkQDC186MBRfrqXTACfVmxUC2Yy0SLxxJnRadxSz2U6
h+8An1S6QRrDpH7oWB6zsqmFvzeBoAcJ
=u0Jh
-----END PGP SIGNATURE-----

