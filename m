MIME-Version: 1.0
In-Reply-To: <20120323141815.GC1359@...1296...>
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
	<20120323141815.GC1359@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 28 Mar 2012 09:03:44 -0400
Message-ID: <CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
Content-Type: multipart/mixed; boundary=14dae93407873f2ec404bc4d3f1d
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
 contains more than an execution path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--14dae93407873f2ec404bc4d3f1d
Content-Type: multipart/alternative; boundary=14dae93407873f2ec104bc4d3f1b

--14dae93407873f2ec104bc4d3f1b
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Mar 23, 2012 at 10:18 AM, Gert Doering <gert@...1296...> wrote:

> Hi,

<snip>

Thank you, Gert, for your detailed comments on my first attempt at this
patch.

The patch is meant to fix problems in the new-in-2.3 checking of options
before trying to create the connection. Options that accept a command
parameter instead of a path parameter fail if the command parameter
includes spaces or more than just a command path. The following options are
affected: --tls-verify, --up, --down, --ipchange, --route-up, --route-pre-down,
and --learn-address.

I've looked into this a bit more, and have found that where the options are
actually used, argv_printf() is called to parse the command line into an
argv structure. argv_printf uses parse_line() to do the actual parsing, and
parse_line() processes single- and double-quotes and backslashes. I
think that when options.c __checks__ an options command arguments, it
should accept exactly the same input as the part of OpenVPN that __uses__
the option's commands.

Attached is a heavily revised version of my original patch. It uses
argv_printf() to __check__ an option's commands, so it accepts exactly the
same input as the parts of OpenVPN that __use__ the options' commands. It
also makes all the relevant changes suggested by Gert except having the
argument following --iproute checked. The --iproute code is handled
differently than the other options, and I think it is OK that we don't do
checking in 2.3 on something that wasn't checked in 2.2 and (apparently)
might go away sometime soon.

The patch is now very straightforward and short:

1. As before, it calls a new function, check_cmd_access() -- instead of
check_file_access() -- for all options that take a command as an parameter
instead of a path.

2. check_cmd_access() uses argv_printf() to extract the command path and
arguments from the command, then passes the command path to
check_file_access(). It ignores the arguments because I can't think of
anything about them that it can check.

There is one part of check_cmd_access() which I took from code in
run_up_down() and I am not sure about -- the three lines:
  gc_arena gc;
and
  gc = gc_new ();
and
  gc_free (&gc);

Are they needed? I put them in because I assume that they set up and tear
down a global garbage-collection area where allocations are made, and that
that area is used by argv_new() and whatever eventually allocates the argv
structure's components when they are created by argv_printf() and/or
parse_line().

--14dae93407873f2ec104bc4d3f1b
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2012 at 10:18 AM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">




Hi,</blockquote><div>&lt;snip&gt;</div><div><br></div><div><div>Thank you, =
Gert, for your detailed comments on my first attempt at this patch.</div><d=
iv><br></div><div>The patch is meant to fix problems in the new-in-2.3 chec=
king of options before trying to create the connection. Options that accept=
 a command parameter instead of a path parameter fail if the command parame=
ter includes spaces or more than just a command path. The following options=
 are affected:=A0--tls-verify,=A0--up,=A0--down,=A0--ipchange,=A0--route-up=
,=A0--route-pre-down, and=A0--learn-address.</div>



<div><br></div><div>I&#39;ve looked into this a bit more, and have found th=
at where the options are actually used, argv_printf() is called to parse th=
e command line into an argv structure.=A0argv_printf uses parse_line() to d=
o the actual parsing, and parse_line() processes single- and double-quotes =
and backslashes. I think=A0that when options.c __checks__ an options comman=
d arguments, it should accept exactly the same input as the part of OpenVPN=
 that __uses__ the option&#39;s commands.</div>




<div><br></div><div>Attached is a heavily revised version of my original pa=
tch. It uses argv_printf() to=A0__check__ an option&#39;s commands, so it a=
ccepts exactly the same input as the parts of OpenVPN that __use__ the opti=
ons&#39; commands. It also=A0makes all the relevant changes suggested by Ge=
rt except having the argument following --iproute checked. The --iproute co=
de is handled differently than the other options, and I think it is OK that=
 we don&#39;t do checking in 2.3 on something that=A0wasn&#39;t checked in =
2.2 and=A0(apparently) might go away sometime soon.</div>




<div><br></div><div>The patch is now very straightforward and short:</div><=
div><br></div><div>1. As before, it calls a new function, check_cmd_access(=
) -- instead of check_file_access() -- for all options that take a command =
as an parameter instead of a path.</div>




<div><br></div><div>2. check_cmd_access() uses argv_printf() to extract the=
 command path and arguments from the command, then passes the command path =
to check_file_access(). It ignores the arguments because I can&#39;t think =
of anything about them that it can check.</div>




<div><br></div><div>There is one part of=A0check_cmd_access()=A0which I too=
k from code in run_up_down() and I am not sure about -- the three lines:</d=
iv><div>=A0 gc_arena gc;</div><div>and</div><div>=A0 gc =3D gc_new ();</div=
><div>

and</div><div>=A0 gc_free (&amp;gc);</div>


<div><br></div><div>Are they needed? I put them in because I assume that th=
ey set up and tear down a global garbage-collection area where allocations =
are made, and that that area is used by argv_new() and whatever eventually =
allocates the argv structure&#39;s components when they are created by argv=
_printf() and/or parse_line().</div>




</div><div><br></div></div>

--14dae93407873f2ec104bc4d3f1b--

--14dae93407873f2ec404bc4d3f1d
Content-Type: application/octet-stream; name="option-checking.diff"
Content-Disposition: attachment; filename="option-checking.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0cdu9pu0

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQotLS0gb3B0aW9ucy5jCShyZXZpc2lvbiAxOTg1KQorKysgb3B0aW9ucy5jCSh3
b3JraW5nIGNvcHkpCkBAIC0yNjU2LDYgKzI2NTYsNDkgQEAKIH0KIAogLyoKKyAqIFZlcmlmaWVz
IHRoYXQgdGhlIHBhdGggaW4gdGhlIGNvbW1hbmQgdGhhdCBjb21lcyBhZnRlciBjZXJ0YWluIHNj
cmlwdCBvcHRpb25zIChlLmcuLCAtLXVwKSBpcyBhCisgKiB2YWxpZCBmaWxlIHdpdGggYXBwcm9w
cmlhdGUgcGVybWlzc2lvbnMuCisgKgorICogImNvbW1hbmQiIGNvbnNpc3RzIG9mIGEgcGF0aCB0
byBhbiBleGVjdXRhYmxlLCBvcHRpb25hbGx5IGZvbGxvd2VkIGJ5IGEgc3BhY2UsIHdoaWNoIG1h
eSBiZQorICogZm9sbG93ZWQgYnkgYXJiaXRyYXJ5IGFyZ3VtZW50cy4gSXQgaXMgTk9UIGEgZnVs
bCBzaGVsbCBjb21tYW5kIGxpbmUuCisgKgorICogVGhlIHBhdGggaXMgZXh0cmFjdGVkIGZyb20g
ImNvbW1hbmQiLCB0aGVuIGNoZWNrX2ZpbGVfYWNjZXNzKCkgaXMgY2FsbGVkIHRvIGNoZWNrIGl0
LiBUaGUgdHlwZSwKKyAqIG1vZGUsIGFuZCBvcHQgYXJndW1lbnRzIHRvIHRoaXMgcm91dGluZSBh
cmUgdGhlIHNhbWUgYXMgdGhlIGNvcnJlc3BvbmRpbmcgY2hlY2tfZmlsZV9hY2Nlc3MoKQorICog
YXJndW1lbnRzIHRvIGZhY2lsaXRhdGUgdGhpcy4KKyAqLworc3RhdGljIGJvb2wKK2NoZWNrX2Nt
ZF9hY2Nlc3MoY29uc3QgaW50IHR5cGUsIGNvbnN0IGNoYXIgKmNvbW1hbmQsIGNvbnN0IGludCBt
b2RlLCBjb25zdCBjaGFyICpvcHQpCit7CisgIHN0cnVjdCBnY19hcmVuYSBnYzsKKyAgc3RydWN0
IGFyZ3YgYXJndjsKKyAgYm9vbCByZXR1cm5fY29kZTsKKworICAvKiBJZiBubyBjb21tYW5kIHdh
cyBzZXQsIHRoZXJlIGFyZSBubyBlcnJvcnMgdG8gbG9vayBmb3IgKi8KKyAgaWYgKCEgY29tbWFu
ZCkKKyAgICAgIHJldHVybiBmYWxzZTsKKworICBnYyA9IGdjX25ldyAoKTsKKwkKKyAgLyogRXh0
cmFjdCBleGVjdXRhYmxlIHBhdGggYW5kIGFyZ3VtZW50cyAqLworICBhcmd2ID0gYXJndl9uZXcg
KCk7CisgIGFyZ3ZfcHJpbnRmICgmYXJndiwgIiVzYyIsIGNvbW1hbmQpOworCisgIC8qIGlmIGFu
IGV4ZWN1dGFibGUgaXMgc3BlY2lmaWVkIHRoZW4gY2hlY2sgaXQ7IG90aGVyd2lzZSwgY29tcGxh
aW4gKi8KKyAgaWYgKGFyZ3YuYXJndlswXSkKKyAgICAgIHJldHVybl9jb2RlID0gY2hlY2tfZmls
ZV9hY2Nlc3ModHlwZSwgYXJndi5hcmd2WzBdLCBtb2RlLCBvcHQpOworICBlbHNlCisgICAgewor
ICAgICAgbXNnIChNX05PUFJFRklYfE1fT1BURVJSLCAiJXMgZmFpbHMgd2l0aCAnJXMnOiBObyBl
eGVjdXRhYmxlIHBhdGguIiwKKyAgICAgICAgICAgb3B0LCBjb21tYW5kKTsKKyAgICAgIHJldHVy
bl9jb2RlID0gdHJ1ZTsKKyAgICB9CisKKyAgZ2NfZnJlZSAoJmdjKTsKKworICByZXR1cm4gcmV0
dXJuX2NvZGU7Cit9CisKKy8qCiAgKiBTYW5pdHkgY2hlY2sgb2YgYWxsIGZpbGUvZGlyIG9wdGlv
bnMuICBDaGVja3MgdGhhdCBmaWxlL2RpcgogICogaXMgYWNjZXNzaWJsZSBieSBPcGVuVlBOCiAg
Ki8KQEAgLTI3MzgsMjAgKzI3ODEsMjIgQEAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ul9PS3xYX09LLCAiLS1jbGllbnQtZGlzY29ubmVjdCBzY3JpcHQiKTsKICAgZXJycyB8PSBjaGVj
a19maWxlX2FjY2VzcyAoQ0hLQUNDX0ZJTEUsIG9wdGlvbnMtPmF1dGhfdXNlcl9wYXNzX3Zlcmlm
eV9zY3JpcHQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJfT0t8WF9PSywgIi0tYXV0
aC11c2VyLXBhc3MtdmVyaWZ5IHNjcmlwdCIpOwotICBlcnJzIHw9IGNoZWNrX2ZpbGVfYWNjZXNz
IChDSEtBQ0NfRklMRSwgb3B0aW9ucy0+dGxzX3ZlcmlmeSwKLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUl9PS3xYX09LLCAiLS10bHMtdmVyaWZ5IHNjcmlwdCIpOwotICBlcnJzIHw9IGNo
ZWNrX2ZpbGVfYWNjZXNzIChDSEtBQ0NfRklMRSwgb3B0aW9ucy0+dXBfc2NyaXB0LAotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBSX09LfFhfT0ssICItLXVwIHNjcmlwdCIpOwotICBlcnJz
IHw9IGNoZWNrX2ZpbGVfYWNjZXNzIChDSEtBQ0NfRklMRSwgb3B0aW9ucy0+ZG93bl9zY3JpcHQs
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJfT0t8WF9PSywgIi0tZG93biBzY3JpcHQi
KTsKLSAgZXJycyB8PSBjaGVja19maWxlX2FjY2VzcyAoQ0hLQUNDX0ZJTEUsIG9wdGlvbnMtPmlw
Y2hhbmdlLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSX09LfFhfT0ssICItLWlwY2hh
bmdlIHNjcmlwdCIpOwotICBlcnJzIHw9IGNoZWNrX2ZpbGVfYWNjZXNzIChDSEtBQ0NfRklMRSwg
b3B0aW9ucy0+cm91dGVfc2NyaXB0LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSX09L
fFhfT0ssICItLXJvdXRlLXVwIHNjcmlwdCIpOwotICBlcnJzIHw9IGNoZWNrX2ZpbGVfYWNjZXNz
IChDSEtBQ0NfRklMRSwgb3B0aW9ucy0+cm91dGVfcHJlZG93bl9zY3JpcHQsCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFJfT0t8WF9PSywgIi0tcm91dGUtcHJlLWRvd24gc2NyaXB0Iik7
Ci0gIGVycnMgfD0gY2hlY2tfZmlsZV9hY2Nlc3MgKENIS0FDQ19GSUxFLCBvcHRpb25zLT5sZWFy
bl9hZGRyZXNzX3NjcmlwdCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUl9PS3xYX09L
LCAiLS1sZWFybi1hZGRyZXNzIHNjcmlwdCIpOworICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKKy8qICoqIFNjcmlwdCBob29rcyB0aGF0IGFjY2VwdCBjb21tYW5kcyAobm90IGp1c3QgcGF0
aHMpICoqICovICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKKyAgZXJycyB8PSBjaGVja19j
bWRfYWNjZXNzIChDSEtBQ0NfRklMRSwgb3B0aW9ucy0+dGxzX3ZlcmlmeSwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBSX09LfFhfT0ssICItLXRscy12ZXJpZnkgc2NyaXB0Iik7CisgIGVy
cnMgfD0gY2hlY2tfY21kX2FjY2VzcyAoQ0hLQUNDX0ZJTEUsIG9wdGlvbnMtPnVwX3NjcmlwdCwK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICBSX09LfFhfT0ssICItLXVwIHNjcmlwdCIpOwor
ICBlcnJzIHw9IGNoZWNrX2NtZF9hY2Nlc3MgKENIS0FDQ19GSUxFLCBvcHRpb25zLT5kb3duX3Nj
cmlwdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBSX09LfFhfT0ssICItLWRvd24gc2Ny
aXB0Iik7CisgIGVycnMgfD0gY2hlY2tfY21kX2FjY2VzcyAoQ0hLQUNDX0ZJTEUsIG9wdGlvbnMt
PmlwY2hhbmdlLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJfT0t8WF9PSywgIi0taXBj
aGFuZ2Ugc2NyaXB0Iik7CisgIGVycnMgfD0gY2hlY2tfY21kX2FjY2VzcyAoQ0hLQUNDX0ZJTEUs
IG9wdGlvbnMtPnJvdXRlX3NjcmlwdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBSX09L
fFhfT0ssICItLXJvdXRlLXVwIHNjcmlwdCIpOworICBlcnJzIHw9IGNoZWNrX2NtZF9hY2Nlc3Mg
KENIS0FDQ19GSUxFLCBvcHRpb25zLT5yb3V0ZV9wcmVkb3duX3NjcmlwdCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBSX09LfFhfT0ssICItLXJvdXRlLXByZS1kb3duIHNjcmlwdCIpOwor
ICBlcnJzIHw9IGNoZWNrX2NtZF9hY2Nlc3MgKENIS0FDQ19GSUxFLCBvcHRpb25zLT5sZWFybl9h
ZGRyZXNzX3NjcmlwdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBSX09LfFhfT0ssICIt
LWxlYXJuLWFkZHJlc3Mgc2NyaXB0Iik7CiAjZW5kaWYgLyogUDJNUF9TRVJWRVIgKi8KIAogICBp
ZiAoZXJycykK
--14dae93407873f2ec404bc4d3f1d--

