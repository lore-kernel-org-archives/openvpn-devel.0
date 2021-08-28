References: <20210811095853.27870-1-a@...2181...>
 <20210827190014.12640-1-a@...2181...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <3e75a75e-2fc7-d6b4-fc46-63c146e4e875@...68...>
Date: Sat, 28 Aug 2021 10:51:58 +0200
MIME-Version: 1.0
In-Reply-To: <20210827190014.12640-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Remove support for PF (Packet Filter)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 27.08.21 um 21:00 schrieb Antonio Quartulli:
> OpenVPN shipped a small packet filtering tool called PF. It has never
> been straightforward as it required a plugin to work. On top of that,
> keeping PF support, makes the code more complicated and increases the
> maintenance cost of OpenVPN.
>
> PF itself is not actually maintained at all and there is little
> motivation in keeping it alive.
>
> Some years ago an IPv6 extension for PF was proposed, but it was never
> picked up for the reasons above.
>
> External (and more appropriate) tools can still be used to implement
> packet filtering on the OpenVPN interface.
>
> Drop PF support for good.
>
> Note that IDs used for external communication (i.e. to the plugin
> or management interface) have been commented out, but not removed, as
> they should not be used in the future.
>
> v2:
> * changed // to /* */

Aside from the comment formatting being incomplete, f. i. //#define
MF_CLIENT_PF still has "//" - why the hassle?
Do we need to maintain C89 compatibility these days?



