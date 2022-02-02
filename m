Content-Type: multipart/mixed; boundary="------------7FEpHigXF4zAAqOsVPEmZuFE"
Message-ID: <c4f62e93-f499-7536-bf77-c34776ebdd4e@...515...>
Date: Wed, 2 Feb 2022 12:40:18 +0200
MIME-Version: 1.0
Content-Language: en-US
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <d9a8901c-55a2-8c63-bfbe-057b3554c4b8@...515...>
In-Reply-To: <d9a8901c-55a2-8c63-bfbe-057b3554c4b8@...515...>
Subject: [Openvpn-devel] Summary of the community meeting (2nd February 2022)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------7FEpHigXF4zAAqOsVPEmZuFE
Content-Type: multipart/alternative;
 boundary="------------zgZXY2KWSQ9RpVoslw3pJwIZ"

--------------zgZXY2KWSQ9RpVoslw3pJwIZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 2nd February 2022
Time: 10:30 CET (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2022-02-02>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, novaflash, ordex and plaisthos participated 
in this meeting.

---

Novaflash will have OpenVPN Inc ("corp") tickets in Trac reviewed.

---

Talked about OpenSSL 3 and easyrsa3. According to wiscii the changes 
required are minor, so we should be able to continue using easyrsa3. The 
fix could even be applied on the fly as a patch.

---

Agreed that we should release 2.4.12 after completing mattock's ongoing 
tasks. In particular:

- Windows EC2 buildbot worker (requires a small fix + buildbot glue)
- ovpn-dco packaging (not started)

---

Talked about OpenVPN 2.6 release. There are plenty of patches to review 
and test. For the gory details refer to the full chatlog.

---

Noted that OpenSSL 3.0.0 (bundled with Fedora 36 right now) should work 
with OpenVPN just fine, even though you might encounter some deprecation 
warnings if using it.

---

Note that there's no progress on the community IPv6 front.

---

The new community Buildbot is now in production and is tracking almost 
all openvpn projects worth building. TheWindows EC2 buildbot worker is 
almost done. The new community VPN server is available for real people 
and buildbot workers alike. Cron2 will try to get one of this buildbot 
workers connected to buildmaster before the next meeting.

-- 

Full chatlog attached
--------------zgZXY2KWSQ9RpVoslw3pJwIZ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode">
      <br>
      Hi,
      <br>
      <br>
      Here's the summary of the IRC meeting.
      <br>
      <br>
      ---
      <br>
      <br>
      COMMUNITY MEETING
      <br>
      <br>
      Place: #openvpn-meeting on libera.chat
      <br>
      Date: Wed 2nd February 2022
      <br>
      Time: 10:30 CET (9:30 UTC)
      <br>
      <br>
      Planned meeting topics for this meeting were here:
      <br>
      <br>
      <a class="moz-txt-link-rfc2396E"
        href="https://community.openvpn.net/openvpn/wiki/Topics-2022-01-19">&lt;https://community.openvpn.net/openvpn/wiki/Topics-2022-02-02&gt;</a>
      <br>
      <br>
      Your local meeting time is easy to check from services such as
      <br>
      <br>
      <a class="moz-txt-link-rfc2396E"
        href="http://www.timeanddate.com/worldclock">&lt;http://www.timeanddate.com/worldclock&gt;</a>
      <br>
      <br>
      SUMMARY
      <br>
      <br>
      cron2, dazo, lev, mattock, novaflash, ordex and plaisthos
      participated in this meeting.
      <br>
      <br>
      ---
      <br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode">Novaflash will have OpenVPN Inc
      ("corp") tickets in Trac reviewed.</div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode">---</div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode">Talked about OpenSSL 3 and
      easyrsa3. According to wiscii the changes required are minor, so
      we should be able to continue using easyrsa3. The fix could even
      be applied on the fly as a patch.<br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode">---<br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><br>
      Agreed that we should release 2.4.12 after completing mattock's
      ongoing tasks. In particular:</div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode">- <span style="font-weight:
        bold;color: #204a87;"></span>Windows EC2 buildbot worker
      (requires a small fix + buildbot glue)<br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode">- ovpn-dco packaging (not
      started)<br>
    </div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><font size="2"><font color="#204a87"><br>
          </font></font></span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">---</span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">Talked about OpenVPN 2.6 release. There are plenty of
        patches to review and test. For the gory details refer to the
        full chatlog.</span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">---<br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">Noted that OpenSSL 3.0.0 (bundled with Fedora 36 right
        now) should work with OpenVPN just fine, even though you might
        encounter some deprecation warnings if using it.<br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">---</span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">Note that there's no progress on the community IPv6
        front.<br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">---</span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;">The new community Buildbot is now in production and is
        tracking almost all openvpn projects worth building. The<span
          style="font-weight: bold;color: #204a87;"> </span>Windows EC2
        buildbot worker is almost done. The new community VPN server is
        available for real people and buildbot workers alike. Cron2 will
        try to get one of this buildbot workers connected to buildmaster
        before the next meeting.<br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"><br>
      </span></div>
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 12px;" lang="x-unicode"><span style="font-weight:
        normal;"></span><span class="moz-txt-tag">-- </span><br>
      <span class="moz-txt-tag"></span>
      <div class="moz-txt-sig">
        <br>
        Full chatlog attached<br>
      </div>
    </div>
  </body>
</html>

--------------zgZXY2KWSQ9RpVoslw3pJwIZ--

--------------7FEpHigXF4zAAqOsVPEmZuFE
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2022-02-02.txt"
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2022-02-02.txt"
Content-Transfer-Encoding: base64

KDExLjMxLjI1KSBtYXR0b2NrOiBoZWxsbwooMTEuMzIuMTkpIGNyb24yOiBtZW93CigxMS4z
My4yMykgbGV2X186IGhlbGxvdwooMTEuMzMuNDIpIGRhem86IFlvIQooMTEuMzYuMjEpIG1h
dHRvY2s6IGh0dHBzOi8vY29tbXVuaXR5Lm9wZW52cG4ubmV0L29wZW52cG4vd2lraS9Ub3Bp
Y3MtMjAyMi0wMi0wMgooMTEuMzYuNDEpIGNyb24yIGhhIHNjZWx0byBjb21lIGFyZ29tZW50
bzogaHR0cHM6Ly9jb21tdW5pdHkub3BlbnZwbi5uZXQvb3BlbnZwbi93aWtpL1RvcGljcy0y
MDIyLTAyLTAyCigxMS4zNy4xMikgY3JvbjI6IHRoYXQgYWdlbmRhIGxvb2tzIG1lc3N5Cigx
MS4zNy40MSkgbWF0dG9jazogSSBjYW5ub3QgYmUgYmxhbWVkIGJlY2F1c2UgaXQncyBub3Qg
bXkgZG9pbmchCigxMS4zOS4xNikgY3JvbjI6IGZpeGVkCigxMS4zOS4zMikgbm92YWZsYXNo
IFt+bm92YWZsYXNoQDE4NS0yMjctNzUtMjQxLmRzbC5jYW1icml1bS5ubF0gw6ggZW50cmF0
byBuZWxsYSBzdGFuemEuCigxMS4zOS41OCkgY3JvbjI6IHVwZGF0ZWQKKDExLjQwLjU2KSBk
YXpvOiBsZXRzIGtpY2sgb2ZmIHdpdGggMiBhbmQgdGhyb3cgbm92YWZsYXNoIHVuZGVyIHRo
ZSBidXMhIDstKQooMTEuNDEuMTIpIG5vdmFmbGFzaDogdGhhdCdzIHdoZXJlIGkgYmVsb25n
CigxMS40My4yOSkgY3JvbjI6IHNvLi4uICMyIGNhbiBiZSBoYW5kbGVkIGZhaXJseSBxdWlj
a2x5Li4uIGNhbiB3ZSByZXZpdmUgdGhlIGFjdGl2aXRpZXMgcmVnYXJkaW5nIGNvcnAgcHJv
ZHVjdHMgaW4gY29tbXVuaXR5IHRyYWMgYWdhaW4sIHBsZWFzZT8gIHRoYW5rcyA6LSkKKDEx
LjQ0LjA4KSBkYXpvOiBub3ZhZmxhc2g6IGNhbiB5b3UgZm9sbG93IHVwIG9uIHRoYXQ/IF5e
XgooMTEuNDQuMTUpIG5vdmFmbGFzaDogeWVhaC4uIGknbGwgc2VlIHdoYXQgY2FuIGJlIGRv
bmUKKDExLjQ0LjI0KSBjcm9uMjogdGhhbmtzIQooMTEuNDQuNDApIGNyb24yOiAjMSBpcyAi
d2hhdCBjYW4gd2UgZG8gYWJvdXQgZWFzeXJzYTMgd2l0aCBvcGVuc3NsMyIKKDExLjQ1LjAx
KSBjcm9uMjogd2lzY2lpIHNheXMgIml0IGp1c3Qgd29ya3MsIHdpdGggYSBzbWFsbCBidWdm
aXgiLCBpZiBJIHVuZGVyc3Rvb2QgdGhhdCByaWdodCAob3ZlciBpbiAjb3BlbnZwbi1kZXZl
bCkKKDExLjQ3LjEyKSBjcm9uMjogY29uc2VxdWVuY2Ugb2YgdGhhdDogd2Ugc2hvdWxkIGJl
IGFibGUgdG8gc2hpcCAyLjYgd2l0aCAzLjAuMQooMTEuNDcuMzcpIGRhem86IFdoYXQgZG9l
cyAic21hbGwgYnVnZml4IiBpbXBseT8KKDExLjQ4LjA5KSBjcm9uMjogZWl0aGVyIGl0IGdl
dHMgZml4ZWQgdXBzdHJlYW0gb3Igd2UgcGF0Y2ggYXQgYnVpbGQgdGltZSAoImxpa2Ugd2Ug
ZG8gZm9yIHBrY3MxMS1oZWxwZXIsIGV0Yy4iKQooMTEuNDguMzcpIGRhem86IGZpbmUgLi4u
IGJ1dCBob3cgc21hbGwgaXMgdGhhdCBmaXg/CigxMS40OS4xNCkgbm92YWZsYXNoOiAyIGlu
Y2hlcwooMTEuNDkuMzUpIGNyb24yOiBoZSBkaWQgbm90IHNheS4uLiBiYWNrbG9nIGluICNv
cGVudnBuLWRldmVsIG9mIHRvZGF5IGFyb3VuZCAyYW0KKDExLjU0LjUzKSBkYXpvOiBJZiBh
biB1cGRhdGVkIGVhc3ktcnNhIGNvdWxkIGJlIG1hZGUgYXZhaWxhYmxlIHNvb25pc2gsIHdl
J3JlIGFsbCBnb29kLiAgVGhhdCB3b3VsZCBhbHNvIGluZGljYXRlIGhvdyBzbWFsbCBhbmQg
aW50cnVzaXZlIHRoZSBjaGFuZ2UgaXMuCigxMS41Ni4xNCkgbWF0dG9jazogKzEKKDExLjU3
LjAwKSBtYXR0b2NrOiBzeW5jIHVwPwooMTEuNTcuNTkpIGNyb24yOiBJIGNhbiBsaXZlIHdp
dGggaGF2aW5nIHRoZSBwYXRjaCBhdmFpbGFibGUganVzdCBmaW5lCigxMS41OC40NCkgY3Jv
bjI6IGdldHRpbmcgdGhlIHBhdGNoIG1lcmdlZCBjb3VsZCBiZSBjb21wbGljYXRlZCwgaWYg
dGhlcmUgaXMgbm8gYWN0aXZlIG1haW50YWluZXIKKDExLjU4LjU4KSBkYXpvOiBXZSBzaG91
bGQgcHJvYmFibHkgZ2V0IDIuNCBpbnRvIHRoYXQgbGlzdCAuLi4uIGRvIHdlIGhhdmUgYW55
dGhpbmcgaW4gdGhlIHBpcGUgZm9yIDIuND8gIEp1c3QgdG8gZG8gdGhlIGxhc3QgcmVsZWFz
ZSBiZWZvcmUgc3dpdGNoaW5nIHRvIG9sZC1zdGFibGUKKDExLjU5LjI1KSBkYXpvOiBjcm9u
MjogSSdsbCB0cnkgdG8gcmVhY2ggb3V0IHRvIGVjcmlzdCBhbmQgY2hlY2sgdGhlIHNpdHVh
dGlvbgooMTEuNTkuMzQpIG9yZGV4OiBoaSBoaQooMTEuNTkuMzUpIGNyb24yOiAyLjQgaGFz
IHNvbWUgbWlub3IgYnVnZml4ZXMKKDExLjU5LjM2KSBvcmRleDogc29ycnkgZm9yIGJlaW5n
IGxhdGUKKDExLjU5LjU5KSBkYXpvOiBEb2VzIDIuNCBoYXZlIGFueSB1bnJldmlld2VkIGNo
YW5nZXMgd2Ugd2FudCB0byBpbmNsdWRlPwooMTIuMDAuMDgpIGNyb24yOiBub3QgdGhhdCBJ
J20gYXdhcmUKKDEyLjAwLjI4KSBkYXpvOiBzbywgYmFzaWNhbGx5IHdlIGNhbiBkbyBhIDIu
NCByZWxlYXNlIGFzIHNvb24gYXMgbWF0dG9jayBpcyByZWFkeSBmb3IgaXQgdGhlbiAuLi4K
KDEyLjAwLjU5KSBtYXR0b2NrOiBJIHN1Z2dlc3QgImFmdGVyIHdpbmRvd3MgRUMyIGJ1aWxk
Ym90IHdvcmtlciBhbmQgYWZ0ZXIgb3Zwbi1kY28gcGFja2FnaW5nIgooMTIuMDEuMTkpIG1h
dHRvY2s6IHRoZSBmb3JtZXIgaXMgbGFja2luZyBhIHNtYWxsIGZpeCAoYXV0aG9yaXphdGlv
biBpc3N1ZSkgKyBidWlsZGJvdCBnbHVlCigxMi4wMS4yNykgZGF6bzogaHR0cHM6Ly90ZXJt
YmluLmNvbS96Y21xICAuLi4uIHNob3J0bG9nIDIuNC4xMSB0byByZWxlYXNlLzIuNAooMTIu
MDEuMzEpIG1hdHRvY2s6IHRoZSBsYXR0ZXIgSSBkaWQgbm90IHN0YXJ0IGRvaW5nLCBidXQg
b3JkZXggbWF5IGJlIG9uIGl0CigxMi4wMi4zNikgZGF6bzogQWdyZWVkIC4uLiBsZXRzIGNv
bXBsZXRlIG9uLWdvaW5nIHRhc2tzLCB0aGVuIGRvIHRoZSAyLjQuMTIKKDEyLjAzLjA4KSBk
MTJmayBoYSBhYmJhbmRvbmF0byBsYSBzdGFuemEgKHF1aXQ6IFJlbW90ZSBob3N0IGNsb3Nl
ZCB0aGUgY29ubmVjdGlvbikuCigxMi4wMy4yMCkgZDEyZmsgW35oZWlrb0BleGl0MC5uZXRd
IMOoIGVudHJhdG8gbmVsbGEgc3RhbnphLgooMTIuMDQuNTUpIG1hdHRvY2s6IDIuNj8KKDEy
LjA1LjA0KSBtYXR0b2NrOiBXaW5kb3dzIGJ1aWxkcyArIG9wZW5zc2w/CigxMi4wNS4yNykg
bGV2X186IHRoZXJlIGFyZSBmZXcgcGF0Y2hlcyB3YWl0aW5nIGZvciByZXZpZXcKKDEyLjA1
LjM1KSBsZXZfXzogcmVsYXRlZCB0byBvc3NsMwooMTIuMDUuMzYpIGNyb24yOiBJIG1hbmFn
ZWQgdG8gZ2V0IG9uZSBidWZmZXIgcGF0Y2ggaW4sIGFuZCB0aGVuIHN0dW1ibGVkIG92ZXIg
d2Fja2luZXNzLi4uIHdpbGwgcmVzdW1lIEFTQVAKKDEyLjA2LjQwKSBkYXpvOiBJJ20gZ29p
bmcgdG8gcmV2aWV3IHRoZSBwYXRjaGVzIGZyb20gb3JkZXggcmVsYXRlZCB0byB0aGUgZmlw
cyBjbGVhbnVwIC4uLi4gb25lIG9mIHRoZW0gbWlnaHQgaGF2ZSBhbiBhY2sgZnJvbSBwbGFp
c3Rob3MgYWxyZWFkeSwgaWlyYwooMTIuMDYuNTUpIGRhem86IEknbGwgdHJ5IHRvIGdldCB0
aGF0IGRvbmUgdG9kYXkKKDEyLjA3LjIwKSBjcm9uMjogb25lIGhhcyBhbiBBQ0ssIGJ1dCB0
aGUgb3RoZXIgdHdvIGFyZSBzb3J0IG9mICJkbyBub3QgdGFrZSB0aGUgZmlyc3QsIHVzZSB0
aGUgb3RoZXIgdHdvIiBhbHRlcm5hdGl2ZQooMTIuMDguMTIpIGRhem86IHJpZ2h0LCBJIGhv
cGUgb3JkZXggY2FuIGhlbHAgbWUgZmlndXJlIG91dCB0aGUgcmlnaHQgb25lcyB0byByZXZp
ZXcgOikKKDEyLjA4LjIzKSBwbGFpc3Rob3M6IHllYWgsIHNvcnJ5LiBHb3QgaW50ZXJydXB0
ZWQgYnkgb3RoZXIgd29yayBhbmQgdGhlbiBsZWZ0IHRoYXQgb24gdGhlIHRhYmxlLiBJIHRo
b3VnaHQgdGhlIG90aGVyIHdvcmsgc2hvbGQganVzdCB0YWtlIGEgZGF5IG9yIHR3byBidXQg
dHVybmVkIG91dCB0byBiZSBtdWNoIG1vcmUKKDEyLjEwLjA4KSBjcm9uMjogd29yayBjYW4g
YmUgc28gYW5ub3lpbmcKKDEyLjE1LjIyKSBvcmRleDogZGF6bzogc3VyZQooMTIuMTUuMzYp
IG9yZGV4OiBJIGFtIGdvaW5nIHRvIHJldmlldyBkYXpvJ3MgcGF0Y2hlcyB0aGF0IGFyZSBw
ZW5kaW5nIG9uIHRoZSBzZWMgbGlzdAooMTIuMTYuMDgpIG9yZGV4OiBkYXpvOiAyMjU3IGFu
ZCAyMjU4IGFyZSB0aGUgcGF0Y2hlcyBuZWVkaW5nIHJldmlldwooMTIuMTYuMjEpIG9yZGV4
OiAyMjU2IGlzIG9ic29sZXRlIGJlY2F1c2Ugb2YgdGhvc2UgdHdvCigxMi4xNi41OSkgb3Jk
ZXg6IEkgQW0gYWxzbyB0ZXN0aW5nIGxldidzIHBhdGNoIGFib3V0IHVzaW5nIG9zc2wzLjAu
MSB3aXRoIG1zdmMKKDEyLjE3LjA0KSBwbGFpc3Rob3M6IHNlbWkgT1Q6IFVidW50dSAyMi4w
NCB3aWxsIGhhdmUgYXQgbGVhc3QgT3BlblNTTCAzLjAuMQooMTIuMTcuNTcpIG9yZGV4OiB5
ZWFoCigxMi4xOC4wMikgb3JkZXg6IHRoZSBzd2l0Y2ggaXMgY2xvc2UhCigxMi4xOS4wNykg
Y3JvbjI6IHBsYWlzdGhvczogd2hhdCBkbyB0aGV5IHBsYW4/ICBzaGlwIGJvdGgsIGZvciBv
bGQgYW5kIG5ldyBzb2Z0d2FyZT8KKDEyLjE5LjEwKSBkYXpvOiBvcmRleDogdGh4ISAgSSds
bCBoYXZlIGxvb2sgYXQgIDIyNTcgYW5kIDIyNTgKKDEyLjE5LjI3KSBtYXR0b2NrOiBJIGFz
c3VtZSB0d28gdmVyc2lvbnMsIHRoYXQncyB0aGUgZGViaWFuIHN0eWxlCigxMi4xOS4zOSkg
ZGF6bzogcGxhaXN0aG9zOiBGZWRvcmEgMzYgd2lsbCBzaGlwIHdpdGggb3BlbnNzbCAzLjAg
Li4uIG5vdCBzdXJlIGlmIC4wIG9yIC4xCigxMi4xOS41NikgY3JvbjI6IC4wIGlzIGJyb2tl
biByZWdhcmRpbmcgZXh0ZXJuYWwgcHJvdmlkZXJzCigxMi4yMC4zMCkgb3JkZXg6IHllYWgK
KDEyLjIyLjIwKSBkYXpvOiAzLjAuMCBpcyB0aGUgbGF0ZXN0IGYzNiBidWlsZCBhdmFpbGFi
bGUgSSdsbCBjaGVjayBmb3IgdGhlIDMuMC4xIHBsYW5zCigxMi4yMi4zNikgZGF6bzogaHR0
cHM6Ly9rb2ppLmZlZG9yYXByb2plY3Qub3JnL2tvamkvYnVpbGRpbmZvP2J1aWxkSUQ9MTgz
MDE0MgooMTIuMjMuMTQpIHBsYWlzdGhvczogZGF6bzogb3BlbnZwbiArIDMuMC4wIHN0aWxs
IHdvcmtzIGJ1dCB5b3Ugd2lsbCB1c2UgdGhlIG9sZCBtZXRob2QgYW5kIGFyZSBkcm93bmVk
IGluIGRlcHJlY2F0aW9uIHdhcm5pbmdzIGZyb20gT3BlblNTTAooMTIuMjMuNTgpIGNyb24y
OiBwbGFpc3Rob3M6IGRvZXMgaXQgcmVhbGx5IHdvcmssIGluY2x1ZGluZyAibGVnYWN5IiBh
bGdvcml0aG1zPwooMTIuMjQuMDEpIGRhem86IFRoYXQncyB3aGF0IEkndmUgc2VlbiBpbiBz
b21lIG9mIHRoZSBvcGVudnBuIGJ1aWxkcyBvbiBmMzYvUmF3aGlkZSwgeWVzIC4uLiBidXQg
aWYgaXQgd29ya3MsIEknbSBsZXNzIGNvbmNlcm5lZC4gIEkgY2FuIGxpdmUgd2l0aCBkZXBy
ZWNhdGlvbiB3YXJuaW5ncyBmb3IgdGhlIHRpbWUgYmVpbmcKKDEyLjI5LjUzKSBtYXR0b2Nr
OiBtb3ZlIG9uPwooMTIuMjkuNTYpIG1hdHRvY2s6IDEgbWludXRlIGxlZnQKKDEyLjMwLjIy
KSBjcm9uMjogaXB2NiB0byBjb21tdW5pdHk/CigxMi4zMC4zMykgbWF0dG9jazogeWVzIGFu
ZCB0aGUgYW5zd2VyIGlzICJubyBwcm9ncmVzcyIKKDEyLjMwLjUzKSBjcm9uMjogaXMgc29t
ZW9uZSBlbHNlIGZpbmRpbmcgdGhpcyBzb21ld2hhdCB1bnNhdGlzZmFjdG9yeT8KKDEyLjMw
LjU3KSBtYXR0b2NrOiB5ZXMKKDEyLjMwLjU5KSBtYXR0b2NrOiBldmVyeWJvZHkKKDEyLjMx
LjAxKSBjcm9uMjogZ29vZCA6KQooMTIuMzEuMDUpIGNyb24yOiBzbyBpdCdzIG5vdCBqdXN0
IG1lIDstKQooMTIuMzEuMzgpIG1hdHRvY2s6IG9wZW52cG4gaW5jIGlzIGp1c3QgYWN0aW5n
IGxpa2UgYSBGb3J0dW5lIDUwMCBjb21wYW55IHdoZXJlIGV2ZXJ5dGhpbmcgaGFwcGVucyBh
dCBhIHNuYWlsJ3MgcGFjZQooMTIuMzEuNDYpIG1hdHRvY2s6IGVzcGVjaWFsbHkgSVB2NiBz
dXBwb3J0CigxMi4zMS40OCkgbWF0dG9jazogOikKKDEyLjMyLjEzKSBjcm9uMjogaGFoYS4u
LiAocGFydCBvZiBteSBkYXkgam9iIGlzICJjb25zdWx0aW5nIGZvciBhIGY1MDAgY29tcGFu
eSB0byBtYWtlIElQdjYgaGFwcGVuIiwgYW5kIEknbSBub3Qgc3VyZSB3aG8gaXMgbW9yZSBh
Z2lsZSBoZXJlLi4uKQooMTIuMzIuMjkpIG1hdHRvY2s6IHRoYXQncyBnb2luZyB0byBiZSBh
IHRvdWdoIHJhY2UgOikKKDEyLjMyLjQ2KSBtYXR0b2NrOiBidWlsZGJvdCBpcyBub3cgaW4g
cHJvZHVjdGlvbiBhbmQgdHJhY2tpbmcgImFsbCBvcGVudnBuIHByb2plY3RzIiB3b3J0aCBi
dWlsZGluZwooMTIuMzIuNTApIG1hdHRvY2s6IHdpbmRvd3MgZWMyIGJ1aWxkZXIgaXMgYWxt
b3N0IGRvbmUKKDEyLjMzLjA0KSBtYXR0b2NrOiBuZXcgY29tbXVuaXR5IHZwbiBpcyBhdmFp
bGFibGUgZm9yIHJlYWwgcGVvcGxlIGFuZCBmb3IgYnVpbGRib3Qgd29ya2VycwooMTIuMzMu
MDgpIGNyb24yOiB2ZXJ5IG5pY2UuICBJJ2xsIHNlZSB0aGF0IEkgY2FuIGdldCBteSBmaXJz
dCBmcmVlYnNkIGJvdCBvcGVyYXRpb25hbCAiYmVmb3JlIHRoZSBuZXh0IG1lZXRpbmchIgoo
MTIuMzMuMjApIG1hdHRvY2s6IG9uY2UgeW91IGdldCB0aGUgdnBuIGdvaW5nIGxldCBtZSBr
bm93CigxMi4zMy4yNCkgY3JvbjI6IHllcAooMTIuMzMuMjUpIG5vdmFmbGFzaDogeW91IGNh
biBtYWtlIHRoYXQgc3RhdGVtZW50IHRydWUgYnkgY2FuY2VsbGluZyBtZWV0aW5ncyB1bnRp
bCB5b3UgaGF2ZSBpdCBvcGVyYXRpb25hbAooMTIuMzMuMzkpIGNyb24yOiBwc3N0CigxMi4z
My4zOSkgbWF0dG9jazogSSBkb24ndCBoYXZlIGEgd29ya2VyIHNlY3Rpb24gZm9yIHlvdXIg
d29ya2VyIHlldCBpbiBidWlsZG1hc3RlciBjb25maWcgYnV0IGNhbiBhZGQgaXQgZWFzaWx5
CigxMi4zNC40NykgbWF0dG9jazogYW55dGhpbmcgZWxzZT8KKDEyLjM3LjE4KSBkYXpvOiAz
CigxMi4zNy4yMSkgZGF6bzogMgooMTIuMzcuMjUpIGRhem86IDEKKDEyLjM3LjI5KSBkYXpv
OiBOb3BlIDopCigxMi4zOC4xMSkgbWF0dG9jazogKzEKKDEyLjM4LjE3KSBtYXR0b2NrOiB3
aWxsIHNlbmQgdGhlIHN1bW1hcnkgbm93LCBqdXN0IHdyYXBwZWQgaXQgdXAK

--------------7FEpHigXF4zAAqOsVPEmZuFE--

