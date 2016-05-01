MIME-Version: 1.0
In-Reply-To: <80711231-C760-410A-B8A5-F2B1D46C22CE@...2127...>
References: <80711231-C760-410A-B8A5-F2B1D46C22CE@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 1 May 2016 18:19:53 +0200
Message-ID: <CAA1AbxLU5HWVrFC+RuLaRD8KPmnamr1enZ9UQ+JRojWfXx9GTA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] ignore the local config file
 t_client.rc in git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

On Fri, Apr 29, 2016 at 1:20 PM, Jens Neuhalfen
<openvpn-devel@...2127...> wrote:
> >From e343a78173ad2b3d31384ece1e7fe245215a5c72 Mon Sep 17 00:00:00 2001
> From: Jens Neuhalfen <jens@...2127...>
> Date: Fri, 29 Apr 2016 13:16:36 +0200
> Subject: [PATCH] ignore the local config file t_client.rc in git
>
> t_client.rc is a config file used in integration tests (t_client.sh).
>
> It is a local (developer/machine) specific file not intended to be verisonized.
> A template file can be found at ./tests/t_client.rc-sample
>
> Signed-off-by: Jens Neuhalfen <jens@...2127...>
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index e154092..0eea06e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -51,8 +51,11 @@ config-msvc-local.h
>  config-msvc-version.h
>  doc/openvpn.8.html
>  distro/rpm/openvpn.spec
> +
>  tests/t_client.sh
>  tests/t_client-*-20??????-??????/
> +t_client.rc
> +
>  src/openvpn/openvpn
>  include/openvpn-plugin.h
>  config-version.h

Makes sense. ACK.

-Steffan

