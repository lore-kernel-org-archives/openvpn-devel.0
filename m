MIME-Version: 1.0
References: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
 <6a1c2a84-0a0b-4a56-5ca1-1ceb78efbca6@...515...>
In-Reply-To: <6a1c2a84-0a0b-4a56-5ca1-1ceb78efbca6@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 26 Mar 2020 23:22:24 -0400
Message-ID: <CAKuzo_hw5TVoYqBHfrivTF9sUEV2WxYaXX9eaPjW57T7yaMB5A@...278...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (26th March
 2020)
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Quoting from the 26th March meeting summary

> Noted that the combination of a username-only --auth-user-pass and
> --management-query-passwords does not work. Dazo will take a stab at
> fixing the actual problem. There is already a
> GET_USER_PASS_PASSWORD_ONLY flag which just needs to be processed
> correctly when the management interface is in action.

That's not very useful as GET_USER_PASS_PASSWORD_ONLY is currently
meant to prompt for the private key password, token password etc. The GUI will
treat any 'Auth' request to mean both username and password. In other
words, a management client only sees the prompt and there is no defined
prompt string for auth-user-pass password only.

Also, asking for a password without at least displaying the username is
confusing and there is currently no way of indicating the username in
such a request.

I considered several options for fixing this but all involve some
regression that may not be acceptable. An option is to step back when
only username is found in the file and ask for both username and password
from the management with the usual Auth request. Do this only if
--management-query-passwords is present.

But even that is a regression as currently, in such cases, the console
will be queried. There could be some users out there with those
options in the config, but not using the GUI or any management client,
and rely on prompting for password via the console.



> An attempt to document the limitation plus related discussion is here:
>
> <https://patchwork.openvpn.net/patch/1040/>
>
> Further discussion of the issue is available here:
>
> <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12835.html>
>

Selva

