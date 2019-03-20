References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
 <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
 <CAKuzo_hbxCOTP_y1_4-i-=8WseuxbnjCEpTkgO5tF=oTcO+W_g@...278...>
 <f4674758-5cf1-b725-c0cf-5f6b4ae3f9fd@...1227...>
 <CAKuzo_gqbf8jUvHYHckbrbV_DZhZhSmeVdXCE_1DQbXxETzOKw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e141ee23-a1c4-fc72-351e-ed1eb148d79b@...1227...>
Date: Wed, 20 Mar 2019 18:43:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gqbf8jUvHYHckbrbV_DZhZhSmeVdXCE_1DQbXxETzOKw@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 
> In case of Android, its only sent to the management, right? As the man
> page is about
> OpenVPN core, I would say the current statement that the option is
> handled only on
> Windows is correct.

Well everything is just to managment on Android, even opening the tun
device. But Android and Win32 are the two platforms on which the core
parses the DNS option and explicity calls functions to set a DNS server.

Arne

