Message-ID: <67d27c26-d751-05a4-9931-9de9080c44be@...1227...>
Date: Sun, 5 Feb 2023 10:46:24 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230204004512.250271-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230204004512.250271-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Conditionally add subdir-objects
 option to automake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 04.02.23 um 01:45 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Eliminates repeated warnings such as
>    warning: source file '$(openvpn_srcdir)/env_set.c' is in a subdirectory,
>    but option 'subdir-objects' is disabled
> - Enabled only for automake >= 1.16 as older versions have a buggy implementation
>    of this option
> 
> Main side effect of this option is that object files like openvpnserv-blockdns.o
> are now created in src/openvpn where block-dns.c resides instead of in
> src/openvpnserv. Same for object files for sources from $(openvpn_srcdir) compiled
> into test executables.
> 
> See also past discussion on this topic:
>    https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg00013.html
> 

Acked-By: Arne Schwabe <arne@...1227...>


