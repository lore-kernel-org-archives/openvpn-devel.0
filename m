References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <7adfcf57-b3dd-0e6a-ced0-2767a5462699@...1435...>
 <c6a491fe-17d2-445c-e99d-511992c33f38@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <a6d2b0f3-7c8f-ed68-0398-a36392d846b0@...1435...>
Date: Fri, 29 Dec 2017 11:58:40 +0100
MIME-Version: 1.0
In-Reply-To: <c6a491fe-17d2-445c-e99d-511992c33f38@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] travis: use clang's -fsanitize=address
 to catch more bugs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 29-12-17 11:32, Antonio Quartulli wrote:
> On 29/12/17 18:00, Steffan Karger wrote:
>> On 29-12-17 10:47, Steffan Karger wrote:
>>> The clang address sanitizer is able to catch quite a number of 
>>> memory-related bugs, such add memory leaks and buffer
>>> under/overruns. So, enable the address sanitizer for one
>>> openssl and one mbedtls build.
>>> 
>>> This would have caught the buffer list unittest memory leak
>>> that <1512724338-22197-1-git-send-email-steffan@...1856...>
>>> wants to fix.
>> 
>> For reference, I've pushed this commit to my own gh fork.  This
>> would be the result based on current master: 
>> https://travis-ci.org/syzzer/openvpn/builds/322839893\
> 
> your travis build is failing and throwing out quite some "errors".
> 
> I personally think we should fix them all before adding the new
> sanitize flag, otherwise travis will just always fail until we fix
> them all.

You already ACK'ed the fix in
<1512724338-22197-1-git-send-email-steffan@...1856...> ;-)

But yeah, it would be nice to apply that fix before this patch.

- -Steffan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJaRh/bAAoJEEEwndWOY1w5kFQH/iJuCx02eIhNexq9o24aYJa4
rFSuOYwM4Qf+AE+ufa6RmMWZd94Ppud3mpoJ/Gpy0wWe3MivmtWWRIBzgQzGZpqG
tpcnJLwBWtxQGL6ZUFyrjNy1QxGRMPFM/dk8fqFW2mwWlmbRzuRxiRpDZf6DYg3d
Lr508W+kSJEDmzk4PCFwyocMNSOSTMbRuOwhd9Urf9y4noptD7PD9aLz9Xr70bOh
pTIymTT3aUKIlGKPdgk5zyFPJJuM+MBgHLnt6o6kyDC5BDWtUFkuitVPxAj5yiMG
W5sQJheXoDKLXuHwDFFBV3XB2p+JPm1NcH96RVbh9EAsHrAwyJba9kWtNFO5+X4=
=v9s+
-----END PGP SIGNATURE-----

