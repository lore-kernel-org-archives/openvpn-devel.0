References: <d925da2c-5715-6452-1c38-097a123c0de1@...277...>
	<CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...>
	<1a7a5efc-2de2-db0b-0aa0-4340379b84f7@...277...>
	<CAKuzo_iB=pNkgkKBD_N-ZPTeeDiEMp_qD7uvHst3dhPMkJ=4Jg@...278...>
From: ValdikSS <valdikss@...277...>
Message-ID: <88b7b1a5-c364-a8d5-9b2e-ee9995acbec7@...277...>
Date: Sun, 4 Jun 2017 10:11:45 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iB=pNkgkKBD_N-ZPTeeDiEMp_qD7uvHst3dhPMkJ=4Jg@...278...>
Content-Type: multipart/alternative;
	boundary="------------DC52195A96C49356669B0B78"
Content-Language: en-GB
Subject: Re: [Openvpn-devel] block-outside-dns and persist-tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Pavel Zhovner <pavel@...2275...>

This is a multi-part message in MIME format.
--------------DC52195A96C49356669B0B78
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Also this:
http://clip2net.com/s/3KOUHWv
"Unable to start OpenVPN Interactive Service on local computer: Error 1075: parent service does not exist or has been marked as removed".
This is on fresh installation.

And this:

Error in add_block_dns_filters(): FwpEngineOpen: open fwp session failed : В системе отображения конечных точек не осталось доступных конечных точек.   [status=0x6d9]
Tue May 30 02:28:26 2017 Blocking DNS failed!

"open fwp session failed : There are no more endpoints available from the endpoint mapper."


On 04.06.2017 07:11, Selva Nair wrote:
>
> On Sat, Jun 3, 2017 at 4:13 PM, ValdikSS <valdikss@...277... <mailto:valdikss@...277...>> wrote:
>
> I did not find any related to failure to remove WFP filters. That specific comment link reads
>
> <quote>
> Sun May 28 18:07:25 2017 Block_DNS: WFP engine opened
> Sun May 28 18:07:25 2017 Error in add_block_dns_filters(): add_sublayer: failed to add persistent sublayer : Отказано в доступе. [status=0x5]
> Sun May 28 18:07:25 2017 Blocking DNS failed!
> Sun May 28 18:07:25 2017 Exiting due to fatal error
> </quote>
>
> Obviously "access denied" due to not running as admin and service not in use.
>
> Selva
>
>
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------DC52195A96C49356669B0B78
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Also this:<br>
    <a class="moz-txt-link-freetext" href="http://clip2net.com/s/3KOUHWv">http://clip2net.com/s/3KOUHWv</a><br>
    "Unable to start OpenVPN Interactive Service on local computer:
    Error 1075: parent service does not exist or has been marked as
    removed".<br>
    This is on fresh installation.<br>
    <br>
    And this:<br>
    <tt><br>
      Error in add_block_dns_filters(): FwpEngineOpen: open fwp session
      failed : В системе отображения конечных точек не осталось
      доступных конечных точек.   [status=0x6d9]</tt><tt><br>
    </tt><tt>Tue May 30 02:28:26 2017 Blocking DNS failed! </tt><br>
    <br>
    "open fwp session failed : There are no more endpoints available
    from the endpoint mapper."<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 04.06.2017 07:11, Selva Nair wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_iB=pNkgkKBD_N-ZPTeeDiEMp_qD7uvHst3dhPMkJ=4Jg@...278...">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Sat, Jun 3, 2017 at 4:13 PM,
            ValdikSS <span dir="ltr">&lt;<a
                href="mailto:valdikss@...277..." target="_blank"
                moz-do-not-send="true">valdikss@...277...</a>&gt;</span>
            wrote:<br>
          </div>
          <div class="gmail_extra"><br>
          </div>
          I did not find any related to failure to remove WFP filters.
          That specific comment link reads</div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px"><br>
          </span></div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">&lt;quote&gt;</span></div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">Sun May 28
            18:07:25 2017 Block_DNS: WFP engine opened</span><br
style="box-sizing:border-box;color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">
          <span style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">Sun May 28
            18:07:25 2017 Error in add_block_dns_filters():
            add_sublayer: failed to add persistent sublayer : Отказано в
            доступе. [status=0x5]</span><br
style="box-sizing:border-box;color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">
          <span style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">Sun May 28
            18:07:25 2017 Blocking DNS failed!</span><br
style="box-sizing:border-box;color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">
          <span style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">Sun May 28
            18:07:25 2017 Exiting due to fatal error</span><br>
        </div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">&lt;/quote&gt;</span></div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px"><br>
          </span></div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">Obviously
            "access denied" due to not running as admin and service not
            in use.</span></div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px"><br>
          </span></div>
        <div class="gmail_extra"><span
            style="color:rgb(42,46,46);font-family:&quot;Helvetica
            Neue&quot;,arial,sans-serif;font-size:15px">Selva</span></div>
        <div class="gmail_extra"><br>
          <br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class="moz-txt-link-freetext" href="http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------DC52195A96C49356669B0B78--

