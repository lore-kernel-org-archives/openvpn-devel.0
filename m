References: <a7450cf9-f278-4e51-0c96-fa9aabddd169@...2181...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <f69a02a5-4e06-00ad-366e-56f5699c4d98@...1147...>
Date: Mon, 7 Dec 2020 10:10:45 +0100
MIME-Version: 1.0
In-Reply-To: <a7450cf9-f278-4e51-0c96-fa9aabddd169@...2181...>
Content-Type: multipart/alternative;
 boundary="------------4C521C94E09DA1AEAB25EA0B"
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] AES-CCM available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------4C521C94E09DA1AEAB25EA0B
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Antonio,

On 06/12/20 17:09, Antonio Quartulli wrote:
> Hi all,
>
> Some people have expressed interest in ovpn-dco supporting AES-CBC.
>
> However, since ovpn-dco is currently using the AEAD kernel crypto API
> only, introducing support for CBC mode would require quite some
> refactoring and we do not really want to do that (the community believes
> that as of now AEAD ciphers should always be preferred moving forward).
>
> In a previous discussion on this mailing list, it was highlighted that
> AES-CCM is nothing else than AES-CBC in disguise as AEAD cipher.
>
> (for the curious: it is AES "Counter with CBC-MAC", known as CCM and
> described in RFC3610).
>
> For this reason I decided to give AES-CCM a try and I implemented in it
> the "aes-ccm" branch of the ovpn-dco repo.
>
> I am not sure if we're going to merge it to master yet, but for now it
> would be interesting to gather feedback from those interested in this
> cipher.
>
> Please note that OpenVPN3 does not yet support this cipher, therefore
> the only way to test AES-CCM in ovpn-dco is to use the ovpn-cli tool
> provided in the tests/ folder.
>
>
> To do so, just specify "aes-ccm" as algorithm when setting a new key.
>
>
>
excellent news!
Thank you very much for adding this so quickly; it won't help Tony He 
though, as he is stuck using a rather old AL314 + R9000 chip which does 
not support CCM or GCM. I just checked the driver code and indeed there 
is no HW support for GCM.  They *do* support some AEAD algorithms:

   authenc-hmac-sha256-cbc-aes
authenc-hmac-sha384-cbc-aes

which are listed as the (true) AEAD equivalent of AES+SHA ; the question 
is : how hard would it be to add support for this (and would it be worth 
it?)

cheers,

JJK

--------------4C521C94E09DA1AEAB25EA0B
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Antonio,<br>
      <br>
      On 06/12/20 17:09, Antonio Quartulli wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:a7450cf9-f278-4e51-0c96-fa9aabddd169@...2181...">
      <pre wrap="">Hi all,

Some people have expressed interest in ovpn-dco supporting AES-CBC.

However, since ovpn-dco is currently using the AEAD kernel crypto API
only, introducing support for CBC mode would require quite some
refactoring and we do not really want to do that (the community believes
that as of now AEAD ciphers should always be preferred moving forward).

In a previous discussion on this mailing list, it was highlighted that
AES-CCM is nothing else than AES-CBC in disguise as AEAD cipher.

(for the curious: it is AES "Counter with CBC-MAC", known as CCM and
described in RFC3610).

For this reason I decided to give AES-CCM a try and I implemented in it
the "aes-ccm" branch of the ovpn-dco repo.

I am not sure if we're going to merge it to master yet, but for now it
would be interesting to gather feedback from those interested in this
cipher.

Please note that OpenVPN3 does not yet support this cipher, therefore
the only way to test AES-CCM in ovpn-dco is to use the ovpn-cli tool
provided in the tests/ folder.


To do so, just specify "aes-ccm" as algorithm when setting a new key.



</pre>
    </blockquote>
    excellent news! <br>
    Thank you very much for adding this so quickly; it won't help Tony
    He though, as he is stuck using a rather old AL314 + R9000 chip
    which does not support CCM or GCM. I just checked the driver code
    and indeed there is no HW support for GCM.  They *do* support some
    AEAD algorithms:<br>
    <br>
    <span class="pl-s">  authenc-hmac-sha256-cbc-aes<br>
    </span><span class="pl-s"><span class="pl-s"> 
        authenc-hmac-sha384-cbc-aes<br>
        <br>
        which are listed as the (true) AEAD equivalent of AES+SHA ; the
        question is : how hard would it be to add support for this (and
        would it be worth it?)<br>
        <br>
        cheers,<br>
        <br>
        JJK<br>
        <span class="pl-pds"></span></span><span class="pl-pds"></span></span>
  </body>
</html>

--------------4C521C94E09DA1AEAB25EA0B--

