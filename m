MIME-Version: 1.0
References: <20200309131728.380-1-simon@...2293...>
 <20200309131728.380-5-simon@...2293...>
In-Reply-To: <20200309131728.380-5-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 23 Mar 2020 15:58:35 +0200
Message-ID: <CAGyAFMWrygn49PaC_u54cqYCcqt5FeMGAR4s0TdCwW0bUQfCBQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 05/12] openvpnmsica: Revise MSI custom
 actions interop
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I must say I am not super familiar with this component nor MSI in general.

Stared at the code, compiled with MSVC and tested some exported
functions with rundll32.

This has removed lots of code, so it makes sense, assuming that all
required functionality is still in place.

It would be nice to have unit tests for msica_arg_* functions -
they're doing dangerous low-level stuff.

Acked-by: Lev Stipakov <lstipakov@...277...>

