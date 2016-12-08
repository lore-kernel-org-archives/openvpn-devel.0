From: David Sommerseth <openvpn@...2080...>
Message-ID: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
Date: Thu, 8 Dec 2016 22:15:15 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Coding style clean-up ... phase 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


Hi all developers!

Gert did quite some efforts preparing the grounds for an uncrustify [1]
configuration in our CodeStyle wiki page.  I have also done several
tests with both astyle [2] and uncrustify, to see what would be most
simple for us to use and cover our needs.  I ended up with throwing out
astyle in the end, as it seems to do some weird stuff in some nested
if() situations (it didn't add the expected braces at the expected
places).  Uncrustify on the other hand is very flexible with an option
set which makes the numerous OpenVPN options look like a short list.

Next thing was that I spent time tweaking Gert's proposal and reviewing
it together with Steffan and Arne.  And I think we have a reasonable
configuration now.  And we're not even using that many options :)

------------------------------------------------------
indent_columns=3D4
indent_with_tabs=3D0
align_with_tabs=3Dfalse
cmt_convert_tab_to_spaces=3Dtrue
indent_braces=3Dfalse
indent_else_if=3Dfalse
indent_switch_case=3D4
indent_label=3D1
pp_space=3Dremove
sp_before_sparen=3Dadd
sp_inside_sparen=3Dremove
sp_cond_colon=3Dadd
sp_cond_question=3Dadd
sp_bool=3Dadd
sp_else_brace=3Dadd
sp_brace_else=3Dadd
pos_arith=3DLead
nl_if_brace=3Dadd
nl_brace_else=3Dremove
nl_elseif_brace=3Dremove
nl_else_brace=3Dremove
nl_else_if=3Dremove
nl_func_type_name=3Dadd
nl_before_case=3Dtrue
nl_assign_leave_one_liners=3Dtrue
nl_enum_leave_one_liners=3Dtrue
nl_brace_fparen=3Dadd
nl_max=3D4
nl_after_func_proto=3D2
code_width=3D80
ls_code_width=3Dfalse
mod_full_brace_if=3Dadd
mod_full_brace_if_chain=3Dfalse
mod_add_long_ifdef_endif_comment=3D20
mod_add_long_ifdef_else_comment=3D5
mod_remove_extra_semicolon=3Dtrue
cmt_c_nl_end=3Dtrue
cmt_star_cont=3Dtrue
------------------------------------------------------

This is fairly inline with the initial agreement from the 2014 Munich
hackathon [3] and the summarized CodeStyle wiki page [4].

This proposal allows for the "open bracing" question, which allows
'} else {'  and '} else if () {'.


So now the bike shed debate opens up ... Is this something we can get
consensus around?

And a few examples of reformatted files:

 tun.c: <https://paste.fedoraproject.org/501999/81229253/>
 ssl.c: <https://paste.fedoraproject.org/502010/22971814/>


[1] <http://uncrustify.sourceforge.net/>
[2] <http://astyle.sourceforge.net/>
[3] <http://community.openvpn.net/openvpn/wiki/MunichHackathon2014>
[4] <https://community.openvpn.net/openvpn/wiki/CodeStyle>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


