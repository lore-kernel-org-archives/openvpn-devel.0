MIME-Version: 1.0
In-Reply-To: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
References: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 13 Apr 2018 14:44:22 -0400
Message-ID: <CAEsd45TB9+r9aSMbyP+ANKqBEcKn6XYfJwoVfzJ9xWkRYiY2PA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Specify platform and version on command
 line.
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
To: Micah Morton <mortonm@...1913...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi.

On Fri, Apr 13, 2018 at 1:23 PM, Micah Morton <mortonm@...1913...> wrote:
> From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep 17 00:00:00 2001
> From: Micah Morton <mortonm@...1913...>
> Date: Fri, 13 Apr 2018 09:55:22 -0700
> Subject: [PATCH] Specify platform and version on command line.
>
> Add --iv-plat and --iv-plat-rel command line args, and use the values
> passed to these args to set IV_PLAT and IV_PLAT_REL info that is pushed
> to the server.

Sounds reasonable, but the new options should be documented on the man
page and in the usage message that's shown to users (in options.c) and
that should be included in this patch.

Best regards,

Jon Bullard

