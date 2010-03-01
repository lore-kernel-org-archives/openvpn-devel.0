Message-ID: <20100301042436.20377.qmail@...1287...>
Date: Mon, 1 Mar 2010 05:24:36 +0100
From: Peter Stuge <peter@...1287...>
References: <1267365582-13629-1-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
In-Reply-To: <1267365582-13629-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] enhance tls-verify possibility
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

David Sommerseth wrote:
> +++ b/options.c
> @@ -529,6 +529,9 @@ static const char usage_message[] =
>    "                  tests of certification.  cmd should return 0 to allow\n"
>    "                  TLS handshake to proceed, or 1 to fail.  (cmd is\n"
>    "                  executed as 'cmd certificate_depth X509_NAME_oneline')\n"
> +  "--tls-export-cert [directory] : Get peer cert in PEM format and store it \n"
> +  "                  in an openvpn temporary file in [directory]. Peer cert is \n"
> +  "                  stored before tls-verify script execution and deleted after.\n"

Please update the man page too.


//Peter

