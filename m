MIME-Version: 1.0
References: <20230518125434.1537-1-lstipakov@...277...>
 <20230518162350.1633-1-lstipakov@...277...>
 <CAKuzo_gU7btMnk2qbwe2maYFjS10FLRVFgV1Uxeyz=4YHorGKA@...278...>
In-Reply-To: <CAKuzo_gU7btMnk2qbwe2maYFjS10FLRVFgV1Uxeyz=4YHorGKA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 19 May 2023 10:11:08 +0300
Message-ID: <CAGyAFMUJA0-sn=Aow=ERYnLLk4FS4gw7XirceKeJcney97L8-Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] tapctl: generate driver-specific
 adapter names
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Hi,

> It looks much simpler to write the above 5 lines as
>
> _stprintf_s(name, name_len, TEXT("%ls #%d"), base_name, i)

Agreed.

> If (adapter_name) is false, we reach here with iResult not set, but it gets referenced below. Add an else { iResult = 1; } or initialize iResult to 1 at top?

Normally this should not happen, adapter_name is currently set either
by --name or using a hwid-generated name. But surely let's handle this
case too.

I think iResult should be set to 0, since if we don't set the name
this is not an error - same behavior has been before.

Agreed with the rest, V3 is coming.

