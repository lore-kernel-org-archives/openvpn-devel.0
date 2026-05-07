Message-ID: <78ef4493-ac68-4b3c-a902-11e792622740@...2108...>
Date: Thu, 7 May 2026 17:10:59 +0200
MIME-Version: 1.0
References: <1777879369.971087242@...3037...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US
In-Reply-To: <1777879369.971087242@...3037...>
Subject: Re: [Openvpn-devel] Fwd: [PATCH] netcfg: handle ParseFromString
 result for protobuf 34 (nodiscard)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KDQvtC80LDQvdC+0LI=?= <dromanov2002@...450...>
Cc: Openvpn-devel@lists.sourceforge.net

On 04/05/2026 09:22, Дмитрий Романов via Openvpn-devel wrote:
> -------- Пересылаемое сообщение --------
> От кого: Дмитрий Романов <dromanov2002@...450...
> <mailto:dromanov2002@...450...>>
> Кому: openvpn-devel <openvpn-devel@lists.sourceforge.net
> <mailto:openvpn-devel@lists.sourceforge.net>>
> Дата: Понедельник, 4 мая 2026, 10:19 +03:00
> Тема: [PATCH] netcfg: handle ParseFromString result for protobuf 34
> (nodiscard)
>  
>  
> Hi,
>  
> Building openvpn3-linux v26 with protobuf 34.x and GCC 15 fails in
> netcfg-dco.cpp: google::protobuf::MessageLite::ParseFromString is now
> [[nodiscard]], and the project builds with -Werror, so ignoring the
> return value becomes a hard error (-Werror=unused-result).
>  
> Check the return value and throw NetCfgException on parse failure,
> consistent with other error handling in this file.
>  
> This should fix distributions that already ship protobuf 34 (e.g. Arch).
>  
> If there is an existing issue on Codeberg for this (e.g. related to
> nodiscard / protobuf 34), please link this patch there.
>  
> Signed-off-by: Dmitriy Romanov <dromanov2002@...450...
> <mailto:dromanov2002@...450...>>

Sorry it took time to resolve this.  I've
just pushed out an git master branch to all the repositories which
includes this fix and a lot of other issues related to building
OpenVPN 3 Linux.

<https://codeberg.org/OpenVPN/openvpn3-linux/commit/18f19569ce2da673b786c848fe6222ffae1809b6>

Your patch did not apply cleanly on my tree, so I had to redo it.
But you're credited in the commit, together with other reporters
of the same issue.

Current git master commit: b8ac395171e6354aa2d27875b76ed9cbc44b99cd

Codeberg: <https://codeberg.org/OpenVPN/openvpn3-linux/src/branch/master>
Radicle: rad:zN58oopqzrAkTregNZaRQpgg7x3c
Radicle: <https://radicle.network/nodes/iris.radicle.xyz/rad:zN58oopqzrAkTregNZaRQpgg7x3c>
GitLab: <https://gitlab.com/openvpn/openvpn3-linux/>
GitHub: <https://github.com/OpenVPN/openvpn3-linux/>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


