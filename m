References: <20180120164114.12478-1-steffan@...1856...>
 <20180126105803.26646-1-steffan@...1856...>
 <CAKuzo_iwkWNzJqRN24LUTaL4G0B_nnDTpCMRAwSrQ_srMzLDxg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <12ec1e85-3ded-86e3-002b-bd98ec2c8372@...1856...>
Date: Thu, 1 Feb 2018 07:34:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iwkWNzJqRN24LUTaL4G0B_nnDTpCMRAwSrQ_srMzLDxg@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Enable stricter compiler warnings by
 default
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 27-01-18 17:47, Selva Nair wrote:
> As this is added by default (not in response to --enable/--disable
> directives), may be better to prepend to user's CFLAGS? I'm not sure
> what the standard practice is, though.. Considering the complexity of
> configury, preserving user's input is hard, so may be ok like this.

Good point.  I'll send a v3 with CFLAGS last (for default flags).

> Just one thing: if we support compilers other than gcc/clang (say,
> xlc) this would need a test like AX_CHECK_COMPILE_FLAG().

Hm, I don't think we do for configure.ac.  We do sort-of support MSVC,
but that doesn't use this build system.  Gert, David, any opinions?

-Steffan

