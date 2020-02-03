MIME-Version: 1.0
References: <1580388208-26594-1-git-send-email-selva.nair@...277...>
 <1580488320-10224-1-git-send-email-selva.nair@...277...>
 <CAGyAFMVO_CUsL_-Wuws4tLnnQWvZCfra0c_=djUzg4XoqtNJcA@...278...>
 <CAGyAFMUovaKR+2UTZXmuBOm8NktYhU0oCa9d6a4ZhZrspmeVew@...278...>
In-Reply-To: <CAGyAFMUovaKR+2UTZXmuBOm8NktYhU0oCa9d6a4ZhZrspmeVew@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 3 Feb 2020 10:10:46 -0500
Message-ID: <CAKuzo_g+oY8_cKjMDKT6i57BYbukEN7=LYqKgK7uExg1GT7YAQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Swap the order of checks for
 validating interactive service user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Feb 3, 2020 at 3:49 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> I am sorry, I have to retract my ACK.
>
> When ValidateOptions is called first and config is non located in global =
directory (Program Files),
> service replies to gui via pipe with error message:
>
> 0x20000001
> You have specified a config file location (client.xxx.ovpn relative to C:=
\Users\lev\OpenVPN\config\client.xxx) that requires admin approval. This er=
ror may be avoided by adding your account to the "OpenVPN Administrators" g=
roup
> (null)
>

Nothing is as simple as it looks, is it..

After the first round of stupidity, I had run-tested version 2,  but
still did not catch this.

> This message is incorrect, since account is in admin group, we just haven=
't checked that yet. When following check verifies that user indeed belongs=
 to the admin group, service runs openvpn and connection got established. B=
y some reasons, above error message is not read on the gui side. However, b=
y adding small delay to service code or a breakpoint, message reaches gui, =
which displays an error.
>

Its a timing bug in the GUI. The I/O completion routine for reading
from the service is initialized from the thread that handles the
connection. But this thread is created in a suspended state and
resumed only after sending the start request to the service from the
main thread. That could be the reason why this message is missed by
the GUI. This needs to be fixed as it could potentially affect normal
operation of the GUI.

> While under normal circumstances it works, I elieve it just works by acci=
dent (error message is not read on gui side without delay on service side).=
 We need to move sending error message out of ValidateOptions.

This error message was originally added so that the GUI can notify the
user with a helpful message. But the GUI now checks config location
and user's group memberships and offers to spawn an elevated process
to add the user to ovpn_admin_group before calling the service.  But
still useful to return this message in case some other client decides
to use the service. I'll move it out of ValidateOptions and add code
to return it only when appropriate.


Selva

