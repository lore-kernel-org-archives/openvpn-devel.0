MIME-Version: 1.0
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
 <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
 <20190629095732.GV1097@...1296...>
 <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
In-Reply-To: <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 29 Jun 2019 11:36:29 -0400
Message-ID: <CAKuzo_ghPjWvSa3=34VS9NHVcr+7LuX2J-YpROPizUszyUiYEg@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sat, Jun 29, 2019 at 10:35 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi,
>
>> So Lev's patch proposes to do service calls for wintun *and* tap6, and
>> do so "always"?  Or only if the registry key says so?
>
>
> Yep, patch always opens wintun and tap6 via service no matter what
> registry key says.

Yes, that's one of my concerns with the patch. Opening tap6 using the
service may be a regression in some installations where limited users
are not allowed to open the device. It also provides more access rights
to the handle as its opened by SYSTEM: the driver sets it as all
access for SYSTEM, RWX for everyone else when AllowNonAdmin
is on. Not sure whether that matters in practice.

Selva

