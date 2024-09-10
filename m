Message-ID: <2e352517-7e11-8fa5-a39f-d19fef73a5ea@...2108...>
Date: Tue, 10 Sep 2024 10:00:00 +0200
MIME-Version: 1.0
References: <CAOrkh=VQFEkK9+8NXSLrKyhjoxd_bvj_3ubS=G1AntZJbJ6_8A@...278...>
 <CAOrkh=VofSeqgYkj1VZaJjX38YVNCOeFSeExOV+keZ_FF1DNLw@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-GB
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

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

Hi!

Sorry for the long reply time.  Just been a bit too hectic lately.

I've seen your patch, and it makes total sense.  It's in my pipe to get 
merged as soon as I have cleaned up a bunch of other changes as well.

Again, sorry for the slow response.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



