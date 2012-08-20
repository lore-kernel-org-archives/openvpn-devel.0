From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 20 Aug 2012 12:37:59 +0200
Message-ID: <20402096.xFgnPfk23D@...1526...>
In-Reply-To: <50321111.7010709@...1114...>
References: <CAHFjfK73YDrEUYL0fi7_8pu=v3W3F-sp=Hty3Un1hyJm=T_79g@...278...>
	<CAHFjfK57m_e7mErUQby-Du-UMmJS9WrVXS=YRVcyM0VXbR9M8w@...278...>
	<50321111.7010709@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.3 alpha - configfile with static
	keyfile does not work!
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
To: Markus Ferlitsch <m.ferlitsch@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Markus

On Monday 20 August 2012 12:27:29 David Sommerseth wrote:
> I just checked the source code quickly, and it certainly looks like
> - --tls-exit depends on tls-server or tls-client.  Or to say it easier,
> it requires --key, --cert and --ca in the config file.  (--server and
> - --client are kind of macros, which then implies enabling --tls-server
> or --tls-client, but bot requires --key, --cert and --ca)
> 
> So if your configuration file does not have --tls-exit explicitly
> mentioned, it sounds like it's the GUI doing this.  I would then
> probably report it as a GUI bug [1].

No need to, really. I'm aware of the bug and will fix it this week.
Could you test a fixed GUI I provide?

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


