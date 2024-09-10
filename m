Message-ID: <3bacc68d-2599-cd7a-53d9-cca7eda6dc0d@...2108...>
Date: Tue, 10 Sep 2024 20:38:04 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAOrkh=VQFEkK9+8NXSLrKyhjoxd_bvj_3ubS=G1AntZJbJ6_8A@...278...>
 <CAOrkh=VofSeqgYkj1VZaJjX38YVNCOeFSeExOV+keZ_FF1DNLw@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <CAOrkh=VofSeqgYkj1VZaJjX38YVNCOeFSeExOV+keZ_FF1DNLw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: reduce hardcode in `asio_path`
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Petr Portnov <mrjarviscraft@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/09/2024 21:43, Petr Portnov wrote:
> Hi there! Any updates on this proposal?
> 
> пн, 2 сент. 2024 г. в 22:34, Petr Portnov <mrjarviscraft@...277... 
> <mailto:mrjarviscraft@...277...>>:
> 
>     Hi there! While working on packaging `openvpn3-linux` for NixOS I've
>     discovered a problem with `asio_path` child path being too strict
>     (since not all distros have `asio` as the parent of `include`
>     directory). Thus I am suggesting a simple patch which allows better
>     control over this path allowing easier integration with distros.
> 

This has been merged and pushed!

commit 75abb7dc9366ba85fb1a144d88f02a1e8a62f538
Author: Petr Portnov <mrjarviscraft@...277...>
Date:   Mon Sep 2 22:25:33 2024 +0300

     build: reduce hardcoded 'asio_path'

     Currently, 'asio_path` variable value is concatenated with
     '/asio/include' to specify the path to custom `asio`
     installation.  The problem is that this is too strict as some
     distros (namely NixOS) may have the 'include' directory with
     a differently named parent.  Thus this change minimizes the
     hardcoded part of the path to make it more flexible.

     Signed-off-by: Petr Portnov <mrjarviscraft@...277...>


Thanks a lot!

-- 
kind regards,

David Sommerseth
OpenVPN Inc



