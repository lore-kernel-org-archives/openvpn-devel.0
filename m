MIME-Version: 1.0
In-Reply-To: <CAKuzo_i70Ws4U9-VTzVug4aLu11Z5nWsFe2dzCvUDPWEhDXi7w@...278...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180807185937.GH55859@...1296...>
 <20180807190716.GI55859@...1296...>
 <CAKuzo_i70Ws4U9-VTzVug4aLu11Z5nWsFe2dzCvUDPWEhDXi7w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Aug 2018 16:33:18 -0400
Message-ID: <CAKuzo_hRO4O2+etQL9Nsp6C4Akvz5feNv0SQZFtAkxyZdjBR1w@...278...>
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

Correcting myself...

>> Found an interesting caveat which should be addressed, I think.
>>
>> Our system (LinOTP) knows "PIN+OTP" or "PIN" as valid input, the
>> latter leading to "send me a token by SMS/e-mail/...".
>>
>> If I press return at the challenge prompt, it seems the SCRV1: string
>> is not formed the way the plugin wants it, and I end up with
>>
>>   pass=SCRV1%3AMTE5NQ%3D%3D
>
> How to format this if response is empty is not clearly documented
> but my impression was that the second ':' (%3A) is required.
>
> management-notes.txt specifies the format as
>
> password "Auth" "SCRV1:<BASE64_PASSWORD>:<BASE64_RESPONSE>"
>
> The Windows GUI prints it using a template "SCRV1:%s:%s", so the second
> colon will be present if response is empty -- if that's not happening
> I would consider that a bug in the GUI.
>
> When password is read from stdin, its formatted as (from misc.c line 358)
>
> buf_printf(&packed_resp, "SCRV1:%s:%s", pw64, resp64);
>
> So that should also contain the second colon.

However. just realized that my plugin patch assumes a non-empty
password and response after base64 decode. Else it gives up on
unpacking and treats it as a regular password.

E.g., in auth-pamc.c (line 316)

   n = plugin_base64_decode(resp, up->response, sizeof(up->response)-1);
   if (n > 0)

I think we could and should accept empty strings for both -- let's fix it.

Selva

