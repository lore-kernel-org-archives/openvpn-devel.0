From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 31 Aug 2012 06:50:27 +0200
Message-ID: <1503504.urtfm6VukR@...1526...>
In-Reply-To: <1344938249-5885-1-git-send-email-dazo@...384...>
References: <1344938249-5885-1-git-send-email-dazo@...384...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] [RFC] Add a warning if
	--client-config-dir related config file cannot be opened
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

Hi David

On Tuesday 14 August 2012 11:57:29 David Sommerseth wrote:
> This will cause a warning in the log file if --client-config-dir
> is configured but OpenVPN could not find or open the config file
> for the connecting client.

There should only be a warning message if --ccd-exclusive is active. Otherwise 
mixed setups, where some users have a CCD entry and others use just the basic 
settings, will end up with a overly polluted log file. Adding a DEFAULT file 
somehow defeats the purpose of CCDs.

However, with --ccd-exclusive there already is a error message, generated in 
ssl_verify.c: "TLS Auth Error: --client-config-dir authentication failed for 
common name '%s' file='%s'".

Regards
Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


