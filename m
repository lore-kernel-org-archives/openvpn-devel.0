References: <d925da2c-5715-6452-1c38-097a123c0de1@...277...>
	<CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...>
From: ValdikSS <valdikss@...277...>
Message-ID: <1a7a5efc-2de2-db0b-0aa0-4340379b84f7@...277...>
Date: Sat, 3 Jun 2017 23:13:23 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...>
Content-Type: multipart/alternative;
	boundary="------------3399DFF290B782993A183D10"
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
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Pavel Zhovner <pavel@...2275...>

This is a multi-part message in MIME format.
--------------3399DFF290B782993A183D10
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 28.05.2017 18:20, Selva Nair wrote:
> Hi,
>
> Copying the -devel list:
>
> On Sun, May 28, 2017 at 10:16 AM, ValdikSS <valdikss@...277... <mailto:valdikss@...277...>> wrote:
>
> Is this only with 2.4.2 or is 2.4.1 also affected?  As you imply, the filters won't persist after the process ends (in this case the service), restarting service should be enough to clear them. Further, even if the openvpn client process terminates without removing the filters, the service should clean up all filters added in that session during the undo() processing. However, that wont happen if the openvpn.exe process fails to exit. Verify that a stale client process is not hanging around.

I believe it was tested with 2.4.2. I cannot reproduce this issue and persons who reported it are not tech-savvy. Pavel configured server to push "persist-tun" to clients and says it works correctly now.

>  
>
> The tap adapter index is used to allow dns traffic through it, not block it, so I would think the failure is in unblocking dns through non-tap adapters. If that is the case, dns should start working again through the tunnel when the client reconnects.
>
> Anyway, we need to see the client logs and any error event logged by the service when this happens. Can you get the user to open a ticket with logs?

Since this service is becoming popular and Pavel has 4000+ users, we have seen a lot of absolutely crazy OpenVPN errors on Windows. Most of them are because of old Windowses with disabled updates, but some of them are interesting, like sometimes block-outside-dns fails to remove it's own filters.

We ask people to create bugs on OpenVPN bugtracker but I think almost nobody feels comfortable for their English and do not do that.

You can skip through comments on https://zaborona.help/ to see some screenshots and logs.
Like this one: https://zaborona.help/faq.html#comment-3328754341


--------------3399DFF290B782993A183D10
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 28.05.2017 18:20, Selva Nair wrote:<br>
    <blockquote type="cite"
cite="mid:CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...">
      <div dir="ltr">
        <div class="gmail_extra">Hi,</div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">Copying the -devel list:</div>
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Sun, May 28, 2017 at 10:16 AM,
            ValdikSS <span dir="ltr">&lt;<a
                href="mailto:valdikss@...277..." target="_blank"
                moz-do-not-send="true">valdikss@...277...</a>&gt;</span>
            wrote:<br>
            <div><br>
            </div>
            <div>Is this only with 2.4.2 or is 2.4.1 also affected?  As
              you imply, the filters won't persist after the process
              ends (in this case the service), restarting service should
              be enough to clear them. Further, even if the openvpn
              client process terminates without removing the filters,
              the service should clean up all filters added in that
              session during the undo() processing. However, that wont
              happen if the openvpn.exe process fails to exit. Verify
              that a stale client process is not hanging around. <br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    I believe it was tested with 2.4.2. I cannot reproduce this issue
    and persons who reported it are not tech-savvy. Pavel configured
    server to push "persist-tun" to clients and says it works correctly
    now.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div> </div>
            <div><br>
            </div>
            <div>The tap adapter index is used to allow dns traffic
              through it, not block it, so I would think the failure is
              in unblocking dns through non-tap adapters. If that is the
              case, dns should start working again through the tunnel
              when the client reconnects.</div>
            <div><br>
            </div>
            <div>Anyway, we need to see the client logs and any error
              event logged by the service when this happens. Can you get
              the user to open a ticket with logs?</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Since this service is becoming popular and Pavel has 4000+ users, we
    have seen a lot of absolutely crazy OpenVPN errors on Windows. Most
    of them are because of old Windowses with disabled updates, but some
    of them are interesting, like sometimes block-outside-dns fails to
    remove it's own filters.<br>
    <br>
    We ask people to create bugs on OpenVPN bugtracker but I think
    almost nobody feels comfortable for their English and do not do
    that.<br>
    <br>
    You can skip through comments on <a class="moz-txt-link-freetext" href="https://zaborona.help/">https://zaborona.help/</a> to see some
    screenshots and logs.<br>
    Like this one: <a class="moz-txt-link-freetext" href="https://zaborona.help/faq.html#comment-3328754341">https://zaborona.help/faq.html#comment-3328754341</a><br>
    <br>
  </body>
</html>

--------------3399DFF290B782993A183D10--

