Date: Sun, 23 Oct 2011 11:33:53 -0400
From: Nathan Stratton Treadway <nathanst@...1517...>
Message-ID: <20111023153353.GX13250@...1518...>
References: <1319366113-6891-1-git-send-email-davids@...1347...>
MIME-Version: 1.0
In-Reply-To: <1319366113-6891-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] Fix PolarSSL and --pkcs12 option issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, Oct 23, 2011 at 12:35:13 +0200, David Sommerseth wrote:
> diff --git a/options.c b/options.c
> index 39e7a57..4fd6933 100644
> --- a/options.c
> +++ b/options.c
> @@ -559,7 +559,9 @@ static const char usage_message[] =
>    "                  by a Certificate Authority in --ca file.\n"
>    "--extra-certs file : one or more PEM certs that complete the cert chain.\n"
>    "--key file      : Local private key in .pem format.\n"
> +#ifndef USE_POLARSSL
>    "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
> +#endif
>    "                  and optionally the root CA certificate.\n"


Shouldn't that "#endif" be one line farther down, so that the "and
optionally the root CA certificate.\n" line is excluded along with the
preceding line?



						Nathan
----------------------------------------------------------------------------
Nathan Stratton Treadway  -  nathanst@...1517...  -  Mid-Atlantic region
Ray Ontko & Co.  -  Software consulting services  -   http://www.ontko.com/
 GPG Key: http://www.ontko.com/~nathanst/gpg_key.txt   ID: 1023D/ECFB6239
 Key fingerprint = 6AD8 485E 20B9 5C71 231C  0C32 15F3 ADCD ECFB 6239

