From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] openvpn-2.0_beta1: Win<->Linux flood ping intermittently stops
References: <twig.1084476377.22440@...41...>
In-Reply-To: <twig.1084476377.22440@...41...>
MIME-Version: 1.0
Message-Id: <200405140115.11642.vda@...216...>
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
Date: Thu May 13 15:16:03 2004
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

On Thursday 13 May 2004 22:26, James Yonan wrote:
> Denis,
>
> Would you mind running the same test with OpenVPN 1.6.0 and see if you get
> the same behaviour?

See my other mail. Looks like I can explain both observations.
openvpn actually not to blame here. :)

I even realized that 'nice +/-N' config option already exists
(but not implemented yet it seems. I've got warning about that
in the log).
--
vda


