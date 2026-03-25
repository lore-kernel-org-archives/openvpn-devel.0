MIME-Version: 1.0
References: <20260322014606.1415363-1-luca.boccassi@...277...>
 <CAKuzo_iwvHHST4br9F+V0vGHQUOBSw0ju_yGTtCXGj7ws59pXA@...278...>
In-Reply-To: <CAKuzo_iwvHHST4br9F+V0vGHQUOBSw0ju_yGTtCXGj7ws59pXA@...278...>
From: Luca Boccassi <luca.boccassi@...277...>
Date: Wed, 25 Mar 2026 22:32:16 +0000
Message-ID: <CAMw=ZnTsSbHyLJKozJANpME3nFm_g4MONhDUfe+ypQS8N4GVgA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] management: add multi-line base64 input
 for passwords
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 25 Mar 2026 at 21:54, Selva Nair <selva.nair@...277...> wrote:
> On Sat, Mar 21, 2026 at 9:47=E2=80=AFPM <luca.boccassi@...277...> wrote:
>>
>> From: Luca Boccassi <luca.boccassi@...277...>
>>
>> Allow management clients to send long passwords via the
>> usual multi-line base64 encoded protocol.
>>
>> A client sends a 'password <type>' line, followed by
>> as many lines (each up to 1024 bytes) as needed, in base64
>> encoded format, terminated by 'END'.
>>
>> This is useful when a password is a JIT-generated use-once
>> token.
>>
>> Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
>
>
> I think this is a step in the right direction: allows arbitrary long pass=
words to be passed via the management interface bringing it in line with st=
din/console input. No other intrusive changes like option parsing. Until no=
w, the largish USER_PASS_LEN =3D 4096 was mostly a waste of space as it was=
 often not possible to use it even locally within the client because of the=
 255 byte restriction in the management interface.
>
> I have only skimmed through the patch, but reusing "password" with no arg=
ument could break existing UI clients, hypothetically.  If any UI client is=
 currently using an empty password to quit the dialog, it will get into a s=
talemate. I guess a new keyword or an extra token after 'Auth'  to indicate=
 multi-line input would be required.
>
> Selva
> P.S.
> Next version could go into gerrit for a more thorough review.

Ok, changed to add a new "password-base64" (I don't think we want a
new third token for "password", as that might be, well, a password?),
and pushed to gerrit:

https://gerrit.openvpn.net/c/openvpn/+/1593

