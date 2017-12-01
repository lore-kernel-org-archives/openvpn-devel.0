References: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56fd237f-ba3f-c65d-9831-bf75d4dd139d@...1227...>
Date: Fri, 1 Dec 2017 14:53:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
Content-Type: multipart/alternative;
 boundary="------------E3043E36CD1CA5CC74672BBE"
Content-Language: de-DE
Subject: Re: [Openvpn-devel] Follow up on sending messages to the GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------E3043E36CD1CA5CC74672BBE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Am 30.11.2017 um 03:03 schrieb Selva Nair:
> Cross-posting to users and devel as this may be of interest to both.
>
> Hi,
>
> I have made a draft implementation of this feature that was discussed
> in a previous thread. A test executable (GUI only) is in this pre-release:
>
> https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
> <https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg>
>
> It would be great if anyone can test this out[*].
>
> Thanks,
>
> Selva
>
> [*] Although virtually any text can be sent, some familiarity with
> openvpn config/ccd parsing/quoting and push processing is necessary to
> get it right for non-trivial messages that contain comment characters,
> commas, new lines etc... Short and simple messages must be easy, though.

Could we have some text stating that clients might only display one
message per connect? At the moment you can have multiple "echo
msg-notify message-title" pushed by the server. I would like to avoid in
my client to implement logic to display multiple messages. If one
message allowed the message can become just an Android notification
without special logic

> msg-window : displayed only when starting from a disconnected state
> not when reconnecting by SIGUSR1 or SIGHUP

We need to clarify this a bit. You probably mean "reconnecting after a
successful" connection. If there are multiple remote in the config and
only the 3rd works you already have had two internal SIGUSR1.

Arne

--------------E3043E36CD1CA5CC74672BBE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 30.11.2017 um 03:03 schrieb Selva
      Nair:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...">
      <div dir="ltr">
        <div>Cross-posting to users and <span class="" id=":64w.1"
            tabindex="-1">devel</span> as this may be of interest to
          both.</div>
        <div><br>
        </div>
        Hi,
        <div><br>
        </div>
        <div>I have made a draft implementation of this feature that was
          discussed in a previous thread. A test executable (GUI only)
          is in this <span class="" id=":64w.2" tabindex="-1">pre</span>-release:</div>
        <div><br>
        </div>
        <div><a
href="https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg"
            target="_blank" moz-do-not-send="true">https://<span
              class="" id=":64w.3" tabindex="-1">github</span>.com/<span
              class="" id=":64w.4" tabindex="-1">selvanair</span>/<wbr><span
              class="" id=":64w.5" tabindex="-1">openvpn</span>-<span
              class="" id=":64w.6" tabindex="-1">gui</span>/releases/tag/v11-<wbr>echo-<span
              class="" id=":64w.7" tabindex="-1">msg</span></a><br>
        </div>
        <div><br>
        </div>
        <div>It would be great if anyone can test this out[*].</div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div><br>
        </div>
        <div><span class="" id=":64w.8" tabindex="-1">Selva</span></div>
        <div><br>
        </div>
        <div>[*] Although virtually any text can be sent, some
          familiarity with <span class="" id=":64w.9" tabindex="-1">openvpn</span>
          <span class="" id=":64w.10" tabindex="-1">config</span>/<span
            class="" id=":64w.11" tabindex="-1">ccd</span>
          parsing/quoting and push processing is necessary to get it
          right for non-trivial messages that contain comment
          characters, commas, new lines etc... Short and simple messages
          must be easy, though.</div>
      </div>
    </blockquote>
    <br>
    Could we have some text stating that clients might only display one
    message per connect? At the moment you can have multiple "echo
    msg-notify message-title" pushed by the server. I would like to
    avoid in my client to implement logic to display multiple messages.
    If one message allowed the message can become just an Android
    notification without special logic<br>
    <span style="display: inline !important; float: none;
      background-color: transparent; color: rgb(36, 41, 46);
      font-family: -apple-system,BlinkMacSystemFont,&quot;Segoe
      UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color
      Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI
      Symbol&quot;; font-size: 16px; font-style: normal; font-variant:
      normal; font-weight: 400; letter-spacing: normal; orphans: 2;
      text-align: left; text-decoration: none; text-indent: 0px;
      text-transform: none; -webkit-text-stroke-width: 0px; white-space:
      normal; word-spacing: 0px;"><br>
      &gt; msg-window : displayed only when starting from a disconnected
      state</span><br style="background-color: transparent; box-sizing:
      border-box; color: rgb(36, 41, 46); font-family:
      -apple-system,BlinkMacSystemFont,&amp;quot;Segoe
      UI&amp;quot;,Helvetica,Arial,sans-serif,&amp;quot;Apple Color
      Emoji&amp;quot;,&amp;quot;Segoe UI Emoji&amp;quot;,&amp;quot;Segoe
      UI Symbol&amp;quot;; font-size: 16px; font-style: normal;
      font-variant: normal; font-weight: 400; letter-spacing: normal;
      orphans: 2; text-align: left; text-decoration: none; text-indent:
      0px; text-transform: none; -webkit-text-stroke-width: 0px;
      white-space: normal; word-spacing: 0px;">
    <span style="display: inline !important; float: none;
      background-color: transparent; color: rgb(36, 41, 46);
      font-family: -apple-system,BlinkMacSystemFont,&quot;Segoe
      UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color
      Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI
      Symbol&quot;; font-size: 16px; font-style: normal; font-variant:
      normal; font-weight: 400; letter-spacing: normal; orphans: 2;
      text-align: left; text-decoration: none; text-indent: 0px;
      text-transform: none; -webkit-text-stroke-width: 0px; white-space:
      normal; word-spacing: 0px;">
      &gt; not when reconnecting by SIGUSR1 or SIGHUP</span><span
      style="display: inline !important; float: none; background-color:
      transparent; color: rgb(36, 41, 46); font-family:
      -apple-system,BlinkMacSystemFont,&quot;Segoe
      UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color
      Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI
      Symbol&quot;; font-size: 16px; font-style: normal; font-variant:
      normal; font-weight: 400; letter-spacing: normal; orphans: 2;
      text-align: left; text-decoration: none; text-indent: 0px;
      text-transform: none; -webkit-text-stroke-width: 0px; white-space:
      normal; word-spacing: 0px;"><br>
      <br>
      We need to clarify this a bit. You probably mean "reconnecting
      after a successful" connection. If there are multiple remote in
      the config and only the 3rd works you already have had two
      internal SIGUSR1.<br>
      <br>
      Arne</span><span style="display: inline !important; float: none;
      background-color: transparent; color: rgb(36, 41, 46);
      font-family: -apple-system,BlinkMacSystemFont,&quot;Segoe
      UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color
      Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI
      Symbol&quot;; font-size: 16px; font-style: normal; font-variant:
      normal; font-weight: 400; letter-spacing: normal; orphans: 2;
      text-align: left; text-decoration: none; text-indent: 0px;
      text-transform: none; -webkit-text-stroke-width: 0px; white-space:
      normal; word-spacing: 0px;"><span style="color: rgb(36, 41, 46);
        font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe
        UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color
        Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI
        Symbol&quot;; font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><br>
      </span></span>
  </body>
</html>

--------------E3043E36CD1CA5CC74672BBE--

