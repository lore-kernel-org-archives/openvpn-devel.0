From: David Sommerseth <davids@...515...>
Date: Wed, 12 Dec 2018 14:34:44 +0100
Message-Id: <20181212133444.23833-1-davids@...515...>
In-Reply-To: <20181130135641.11533-3-gert@...1296...>
References: <20181130135641.11533-3-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] uncrustify openvpn/ sources
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: gert@...1296...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  Checked with re-running uncrustify.  It did find two more places
which needed fixing, both came from commit e61b401ac50d2a9cfab which
were added after this patch-set, so not a fault of this patch.  This
can be fixed afterwards.

I did one-on-the-fly fix as well, in plugin.c - plugin_call_item() -
which uncrustify did not change with a re-run.

The patch resulted in this (line 549) 
- ---------------------------------------------------
  struct openvpn_plugin_args_func_in args = { type,
                                              (const char **const) a.argv,
                                              (const char **const) envp,
                                              p->plugin_handle,
                                              per_client_context,
                                              (current_cert ? certdepth : -1),
                                              current_cert};
- ---------------------------------------------------

I changed the last line above to:  "current_cert };" (adding a space).
This was due to the initial spacing in the opening bracket, to be
consistent with opening and closing.


Your patch has been applied to the master branch

commit f57431cdc88f22fa4d7962946f0d3187fe058539
Author: Gert Doering
Date:   Fri Nov 30 14:56:41 2018 +0100

     uncrustify openvpn/ sources

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20181130135641.11533-3-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17970.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcEQ5sAAoJEIbPlEyWcf3yOh0P/AihfHG6OP8Gi2H1Z4jXrSJP
+hszq/pLeP1BjOfArE6+DNHHR2AhMXj0qUzx0e0CvqGVvlTdMpLorXk9jP2oSBFg
bpBG/YVyGl0QPv+7F9lo2YOOZIazOxwk3IqBBE2RZt4v12gShX5cWvvrbUJgN6Xl
+qhEzIhWJbCjAVQza8V0EHP3/agieLbNK2PvhfPe8/0muHou99sBRwWhVaJvqsoi
tyxAMsort/6IyWc/Il185TNqyK4+a6hpNCpvXBPFQBehL5SQnw87kXeTxsbZtFxT
ERO2ZD14HyNgdFCJeaAKOZCZckenQlQJp5wyj7gsW5GSylKGPrYOgTbN7ynVWm3y
wi/T8MvQz40YmBCitpMMxPN33EPLMz0gchwpp9Wf+cj+Qm02uQso5khO6lcJF/yw
m8S+mIdCce+JSBvxjwhyMOEXwu/iHECO9jmoSqVcFKpXKEML3gEisIAvwofOjCyS
oGT74wcW0VgnsYLfLI9XXC87ncqtVNYd4VObWaGOovtD9W4R+53PQIC10qhPg36a
gGIpfbp447l7eGrP0rznjRmorjnPh+1SbW4kgvPQkjf+eexlb0n7wLLzorKeYuH4
9h7WMHgCO/AKR7YzT2TU2m+7xFMDX+0X8fn0Ef+1/E4fDftFMpJaaM8UB1J7oJrO
yMCmlIjwHupgMtfH5OvK
=SBiH
-----END PGP SIGNATURE-----

