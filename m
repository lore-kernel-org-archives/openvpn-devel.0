From: Jeremie Courreges-Anglas <jca@...2272...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
	<CAKh=nwF2mKg_YTz34b_wH9c3dLj6ht+jvZnozzB=zXZ1n17fEQ@...278...>
Date: Thu, 22 Jun 2017 02:41:31 +0200
Message-ID: <87efucvop0.fsf@...2274...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net


Hi,

Emmanuel Deloget <logout@...260...> writes:

> Hi David,
>
> On Wed, Jun 21, 2017 at 11:06 PM, David Sommerseth <
> openvpn@...2080...> wrote:
>
> =E2=80=8B<snip>=E2=80=8B
>
>
>> But for reasons unknown to me, those tarballs got re-created somewhere
>> later in the release chain.  The contents of all tarballs are
>> essentially the same, but due to the "nice" artefact that the tar format
>> is non-deterministic on the output, even though the input is the same,
>> that begins to prepare the stage for this chaos.  Especially when what
>> is being uploaded is partly from the initial run and then some files
>> from a different run
>> =E2=80=8B.
>>
>
> =E2=80=8BIt might be possible to pay with several tar options, including:
>
> --sort=3Dname : sort added files by name, and not by the order specified =
by
> the OS
> --mtime=3DDATE-OR-FILE : set mtime of added file to a known value (either=
 the
> mtime of a file or an arbitrary date/time string).  =E2=80=8B
>
> =E2=80=8BThese two options should help=E2=80=8B

--sort and --mtime seem like GNU tar options.

It would be cool if whatever is used to produce the tarballs was
portable to systems where the default tar program is not GNU tar.
If those tar options end up being used, then it would make sense to add
a knob to specify the the GNU tar program used to build the tarballs.

> =E2=80=8BBoth options are being used by the LEDE project=E2=80=8B which c=
laim support of
> reproducible builds for a limited list of targets (tar is used when
> building packages [1]).
>
> =E2=80=8B[1]
> https://git.lede-project.org/?p=3Dsource.git;a=3Dblob;f=3Dscripts/ipkg-bu=
ild#l142=E2=80=8B

Since OpenVPN uses automake, I'll just mention that the automake folks
also discussed reproducible tarballs:

  https://lists.gnu.org/archive/html/automake/2015-12/msg00012.html

--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

