From: David Sommerseth <openvpn@...2080...>
References: <1472162097-17855-1-git-send-email-davids@...515...>
	<20160826131442.GY78279@...1296...>
Message-ID: <d14d0d8f-dc22-f1d4-c53b-06af63b4f6e0@...2080...>
Date: Fri, 26 Aug 2016 18:13:18 +0200
MIME-Version: 1.0
In-Reply-To: <20160826131442.GY78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client connection instant timeout
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/08/16 15:14, Gert Doering wrote:
> If we keep the other one (Arne had some reservations because the
> amount of code in the "now-privileged" part is bigger than "just
> bind"), then this is a working fix - so, conditional ACK.

If you look at the diff with these two patches and without, you
basically move the do_uid_gid_chroot() from above
do_init_server_poll_timeout() to down below do_init_2().  So this last
patch just ensures the order of do_init_server_poll_timeout() and
do_init_2() is preserved.

I can somehow see the argument that do_init_server_poll_timeout() don't
need to run privileged, but since do_init_2() requires it and
do_init_2() again depends on do_init_server_poll_timeout() having run  I
found this a more sane approach.  Especially when considering what the
event_timeout_init() call inside the do_init_server_poll_timeout()
really does.  This isn't really critical code paths, not even depending
on data from the a user at all.

So if Arne feels we should reduce the amount of code running privileged
during the init phase, that needs to be a very different solutions to
most of the init functions.  But I agree we probably can look into
reducing the amount of privileged code, but I don't see that as a too
urgent issue as of now.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXwGqdAAoJEIbPlEyWcf3yk4UP/3pluKaVMOdgVGJW9F0DRdZb
nS7xltrY/hU80T+hnphmlLJ533UXFsMbwikvqdmbmfdUymEioGjIEmvwfrZ7pQgI
rwGf0FW6YHG/MpzZsfUUdgbCg36ea3PHcT2QJ/wvGeUKRLuEkzDAxuIQkdtbI/X4
iOrpEgIk30mjQ5UH14FMTgEG8UbQZuNiAzGe6fPftCJQI6asiv6pGheP2EpA82ll
+EcSgJHHtwrDBZkYCqE31pxKNRO7NXDkm1aDxS06HNDkgc/9sQR+enZakFQ1JAOA
Sb2/L24DyplfHcsn6r56ZMfsEhCS57X7cSmjeb4w1b9FG6jicGrKD3bqh+sn3SFi
MOPYy78ITVqZ+gKwgrFXgp/Upr7qAm3dHF/l9lE8F8IVXlz6oRa1GDlBDd4UPh6i
f1MwHxuw6MBhTfEJV86I4R0m3AWMbV4GPZDmO7UXnyoULs9OSIzfr46Jrr3BlTKD
N0xqSFUxpMP6X8yp5fO8GXvqEZWhyCpjIQ+hIzo8SslL7ets1sgfvIu7Q0mz2ViL
+w5y10SRLTRxoDjAtZCk04HI5DEDS4awvPq7HWFaswkPW6rbnOlfzPbzwxO4UyOP
BWIxjTNa1RPazGGZx9cqsrcZWTW4WWuKuDQCJqp6AQ2g2tAjogY0/9DJPiO2Dk84
MwMhBbTdQFCe7bjxAwVF
=KKoV
-----END PGP SIGNATURE-----

