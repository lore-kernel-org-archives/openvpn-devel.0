Content-Type: multipart/alternative;
 boundary="------------J0JtZl7tPDwLsHS9ceiW3Fn0"
Message-ID: <3f6a0ee2-76c0-4ecd-8c11-e5babfb4356a@...2751...>
Date: Wed, 15 Nov 2023 14:16:04 +0100
MIME-Version: 1.0
From: Johan Draaisma <johan@...2751...>
Content-Language: en-US
Subject: [Openvpn-devel]  IRC community meeting summary
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
--------------J0JtZl7tPDwLsHS9ceiW3Fn0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 15 November 2023:

  * *Updated: OpenVPN 2.6.7 release*
    /The 2.6.7 release was made last week on November 9th 2023./
    /There was a segfault crash reported that points to double check
    buffer leak code./
    /There was a mention of fragment 0 not working anymore (since
    2.6.1). This was from documentation 12 years old. But we can still
    look into handling this case better./
    /There was a question from glcox on whether copr can hold older
    versions as well to rollback to. There are of course always options
    like using packages.openvpn.net for this or upstreaming to EPEL
    repos or such. But unfortunately copr has the limitation that it
    only can have one build. So there is no easy solution here with
    copr. The effort involved to get another solution is stopping us at
    this moment to implement a solution. dazo does mention that perhaps
    modules or streams for various versions on EPEL could be a solution.
    Ideally we'd have someone from EPEL repository to collaborate with./

  * *New: OpenVPN 2.6.8 release*
    /There is a fix available for the crash in 2.6.7. We will put this
    into 2.6.8 and release soon./
    /There are 2 patches from lev that will go in as well./
    /Intention is to get this out this week (Friday likely)./

  * *New: donations for OpenVPN community*
    /There is currently no place to donate money to the community./
    /The question is, do we want to allow donations? The answer is yes./
    /We need to figure out how to deal with that legally, and what
    payment methods to accept and how./
    /Probably credit card is a must. Maybe paypal as well. Bitcoin seems
    to encounter some resistance in the discussions./
    /We definitely do not want the donation thing to be forced - have a
    mechanism to do it, but keep it out of the way./
    /Random things yelled out (to investigate): legal entity? stripe?
    paypal? creditcard? open collective? github sponsors? linux
    foundation? sf conservancy?/

  * *Updated: Publish security assessment of OpenVPN2 codebase on main
    website.*
    /Expected to be published this week./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------J0JtZl7tPDwLsHS9ceiW3Fn0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 15 November 2023:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenVPN 2.6.7 release</strong><br>
        <em>The 2.6.7 release was made last week on November 9th 2023.</em><br>
        <em>There was a segfault crash reported that points to double
          check buffer leak code.</em><br>
        <em>There was a mention of fragment 0 not working anymore (since
          2.6.1). This was from documentation 12 years old. But we can
          still look into handling this case better.</em><br>
        <em>There was a question from glcox on whether copr can hold
          older versions as well to rollback to. There are of course
          always options like using packages.openvpn.net for this or
          upstreaming to EPEL repos or such. But unfortunately copr has
          the limitation that it only can have one build. So there is no
          easy solution here with copr. The effort involved to get
          another solution is stopping us at this moment to implement a
          solution. dazo does mention that perhaps modules or streams
          for various versions on EPEL could be a solution. Ideally we'd
          have someone from EPEL repository to collaborate with.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: OpenVPN 2.6.8 release</strong><br>
        <em>There is a fix available for the crash in 2.6.7. We will put
          this into 2.6.8 and release soon.</em><br>
        <em>There are 2 patches from lev that will go in as well.</em><br>
        <em>Intention is to get this out this week (Friday likely).</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: donations for OpenVPN community</strong><br>
        <em>There is currently no place to donate money to the
          community.</em><br>
        <em>The question is, do we want to allow donations? The answer
          is yes.</em><br>
        <em>We need to figure out how to deal with that legally, and
          what payment methods to accept and how.</em><br>
        <em>Probably credit card is a must. Maybe paypal as well.
          Bitcoin seems to encounter some resistance in the discussions.</em><br>
        <em>We definitely do not want the donation thing to be forced -
          have a mechanism to do it, but keep it out of the way.</em><br>
        <em>Random things yelled out (to investigate): legal entity?
          stripe? paypal? creditcard? open collective? github sponsors?
          linux foundation? sf conservancy?</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Publish security assessment of OpenVPN2
          codebase on main website.</strong><br>
        <em>Expected to be published this week.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------J0JtZl7tPDwLsHS9ceiW3Fn0--

