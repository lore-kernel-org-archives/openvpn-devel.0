From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 10 Oct 2012 10:13:36 +0200
Message-ID: <3225194.uqCr5OXhPF@...1526...>
In-Reply-To: <20121009185233.GS48053@...1777...>
References: <20121009185233.GS48053@...1777...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Backslash in user/pass breaks OpenVPN-GUI
	management authentication
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

Hi Adam

On Tuesday 09 October 2012 14:52:33 Adam McDougall wrote:
> This report concerns the OpenVPN-GUI application included with
> 2.3-alpha3 and 2.3_beta1.  I am excited to see native support for the
> Management Interface which I will ultimately need if I start deploying
> the Windows client, but I discovered username/password authentication
> chokes if either contain a backslash: \

Thanks for the report. Currently "special" characters in username and password 
are not quoted. I've had a report about a double quote breaking auth as 
well... and forgot about fixing it. =) Expect this to be fixed in the next 
beta release. And again, thanks for testing!

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


