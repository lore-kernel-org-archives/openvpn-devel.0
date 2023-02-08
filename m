Content-Type: multipart/alternative;
 boundary="------------ESLaoZ10TYOAhEXKg9teYfgR"
Message-ID: <94f09f2f-6d9d-039b-f183-c4f3df581965@...1227...>
Date: Wed, 8 Feb 2023 09:55:37 +0100
MIME-Version: 1.0
References: <20230208001819.244694-1-arne@...1227...>
 <20230208001819.244694-2-arne@...1227...>
 <CAKuzo_gqTixNXNbTG+PfYOm2i7WcUtzKZjbL4vTQvh_x_5gCRw@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_gqTixNXNbTG+PfYOm2i7WcUtzKZjbL4vTQvh_x_5gCRw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] Conditionally add subdir-objects
 option to automake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------ESLaoZ10TYOAhEXKg9teYfgR
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


Am 08.02.2023 um 01:40 schrieb Selva Nair:
>
>
> On Tue, Feb 7, 2023 at 7:18 PM Arne Schwabe <arne@...1227...> wrote:
>
>     From: Selva Nair <selva.nair@...277...>
>
>     - Eliminates repeated warnings such as
>       warning: source file '$(openvpn_srcdir)/env_set.c' is in a
>     subdirectory,
>       but option 'subdir-objects' is disabled
>     - Enabled only for automake >= 1.16 as older versions have a buggy
>     implementation
>       of this option
>
>     Main side effect of this option is that object files like
>     openvpnserv-blockdns.o
>     are now created in src/openvpn where block-dns.c resides instead of in
>     src/openvpnserv. Same for object files for sources from
>     $(openvpn_srcdir) compiled
>     into test executables.
>
>     See also past discussion on this topic:
>     https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg00013.html
>
>     Signed-off-by: Selva Nair <selva.nair@...277...>
>     Signed-off-by: Arne Schwabe <arne@...1227...>
>
>
> I'm a bit confused here -- it seems you have made some edits to my 
> patch (signed-off), but not clear what has changed.


I didn't make changes as I said in the cover letter. The signoff 
automatically happens since with patch sending.

Arne

--------------ESLaoZ10TYOAhEXKg9teYfgR
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 08.02.2023 um 01:40 schrieb Selva
      Nair:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_gqTixNXNbTG+PfYOm2i7WcUtzKZjbL4vTQvh_x_5gCRw@...278...">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Tue, Feb 7, 2023 at 7:18
            PM Arne Schwabe &lt;<a href="mailto:arne@...1227..."
              moz-do-not-send="true" class="moz-txt-link-freetext">arne@...1227...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">From: Selva Nair &lt;<a
              href="mailto:selva.nair@...277..." target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">selva.nair@...277...</a>&gt;<br>
            <br>
            - Eliminates repeated warnings such as<br>
              warning: source file '$(openvpn_srcdir)/env_set.c' is in a
            subdirectory,<br>
              but option 'subdir-objects' is disabled<br>
            - Enabled only for automake &gt;= 1.16 as older versions
            have a buggy implementation<br>
              of this option<br>
            <br>
            Main side effect of this option is that object files like
            openvpnserv-blockdns.o<br>
            are now created in src/openvpn where block-dns.c resides
            instead of in<br>
            src/openvpnserv. Same for object files for sources from
            $(openvpn_srcdir) compiled<br>
            into test executables.<br>
            <br>
            See also past discussion on this topic:<br>
              <a
href="https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg00013.html"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg00013.html</a><br>
            <br>
            Signed-off-by: Selva Nair &lt;<a
              href="mailto:selva.nair@...277..." target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">selva.nair@...277...</a>&gt;<br>
            Signed-off-by: Arne Schwabe &lt;<a
              href="mailto:arne@...1227..." target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">arne@...1227...</a>&gt;<br>
          </blockquote>
          <div><br>
          </div>
          <div>I'm a bit confused here -- it seems you have made some
            edits to my patch (signed-off), but not clear what has
            changed.</div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I didn't make changes as I said in the cover letter. The signoff
      automatically happens since with patch sending.</p>
    <p>Arne<br>
    </p>
  </body>
</html>

--------------ESLaoZ10TYOAhEXKg9teYfgR--

