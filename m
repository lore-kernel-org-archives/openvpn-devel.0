MIME-Version: 1.0
In-Reply-To: <20180807185937.GH55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180807185937.GH55859@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Aug 2018 15:15:32 -0400
Message-ID: <CAKuzo_g3Qc2Sk4sWQb82R+r=Z6XtjQqn53QF-ua2-sM+f2+VMA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Aug 7, 2018 at 2:59 PM, Gert Doering <gert@...1296...> wrote:

...some good comments snipped...

>
> There's another catch which we might want to at least document: if you
> build this plugin and run it from a slightly older openvpn binary which
> doesn't export the base64 functions, it will core dump most ungraciously
>
> Aug  7 20:17:19 openvpn-tcp kernel: pid 49459 (openvpn), uid 0: exited on signal 11 (core dumped)
>
> (unsurprisingly, jumping over an uninitialized function pointer)
>
>
> So, shall we bump the plugin API version "with base64" to 5, and change
> this plugin to actually check it?
>
> (Applying it anyway, because this can all be addressed in a subsequent
> patch)

Oh, the version bump was overlooked... David's export patch was
obviously written
assuming it will get merged soon after the secure_memzero export patch
but we took
a year and some to get there :)

Let's bump the plugin struct version and add a check for it in this plugin.

Selva

