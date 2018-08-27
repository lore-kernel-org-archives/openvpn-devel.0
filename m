MIME-Version: 1.0
In-Reply-To: <7e4cbf14-4f3e-4564-0328-d7daec2b4fb8@...1227...>
References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
 <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
 <20180824191654.GK997@...1296...>
 <CAJY0qZ+RSaUQZ28EMjkr0B5i-wT4ZG--YB6jsgBBiMKby2vh1A@...278...>
 <7e4cbf14-4f3e-4564-0328-d7daec2b4fb8@...1227...>
From: Derek Zimmer <derek@...2095...>
Date: Mon, 27 Aug 2018 03:10:31 -0500
Message-ID: <CAJY0qZJk8i7si2v9vVU2ki2s73pTAiX4KcQX6uoCoC=25s3e9A@...278...>
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
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
Cc: openvpn-devel@lists.sourceforge.net

>That is a terrible idea. The intention is good but users will then opt
>out of encryption because they want compression or build stacked VPNs.

That was the point of the idea though. If you want to go that far to
go around security, you are very aware of the consequences of what
you're doing. If we don't want to force the users hand, a big and ugly
warning that shows up when compression + encryption is enabled may
lead to the same end result.

In my opinion as long as the user is acutely aware of the risks and we
make the documentation and warnings very clear, the project is as safe
as it can be from user error driven security suicide.
Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund


On Mon, Aug 27, 2018 at 2:25 AM, Arne Schwabe <arne@...1227...> wrote:
> Am 27.08.18 um 00:55 schrieb Derek Zimmer:
>> There's always the option of not allowing encryption to be enabled
>> with compression enabled. This keeps things like using OpenVPN as
>> fancy proxy working without endangering the privacy VPN use-case.
>
> That is a terrible idea. The intention is good but users will then opt
> out of encryption because they want compression or build stacked VPNs.
>
> Arne

