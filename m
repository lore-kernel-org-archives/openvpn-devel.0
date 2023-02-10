MIME-Version: 1.0
References: <20230208001819.244694-3-arne@...1227...>
 <20230208005925.393200-1-selva.nair@...277...>
 <Y+azhVMqdJb/6gAN@...1296...>
In-Reply-To: <Y+azhVMqdJb/6gAN@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 10 Feb 2023 18:10:41 -0500
Message-ID: <CAKuzo_imMOa+UC2FngyyyCvGpERdoyrRNpYnyqEs9+6s4q8_8Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000002b26e405f4609c20"
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Build unit tests in mingw
 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000002b26e405f4609c20
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Feb 10, 2023 at 4:13 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Feb 07, 2023 at 07:59:25PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Minor changes to the build system to include some
> >   dependencies for Windows build
> >
> > - test_tls_crypt not built as it will pull in win32.c and
> >   its dependencies
> >
> > - If cross-compiling, "make check" will only build the tests but not
> >   run any. Copy to Windows and run manually. Executables are in
> >   <buid-dir>/tests/unit_tests/openvpn/.libs/ and these depend on
> >   cmocka.dll in addition to openssl libs that some tests link to.
>
> I am something wrong, or I'm missing some bits.
>
> I took this patch, on top of commit e80720ef939 ("top of master as of
> now").  MinGW on Ubuntu.  "autoreconf -iv", make clean, then
> make && make check.
>
> make check claims
>
> make[4]: Entering directory '/home/gert/mingw/openvpn.git/tests'
> ==================
> All 0 tests passed
> ==================
>
> ... but it seems to have done... nothing?
>
> gert@...2713...:~/mingw/openvpn.git$ ls -l tests/unit_test/openvpn/.libs
> ls: cannot access 'tests/unit_test/openvpn/.libs': No such file or
> directory
>
> ... given argv_testdriver exists, I should find "something" with argv*.o*
> here...
>
> gert@...2713...:~/mingw/openvpn.git$ find . -name "*argv*o"
> ./tests/unit_tests/openvpn/.deps/argv_testdriver-mock_get_random.Po
> ./tests/unit_tests/openvpn/.deps/tls_crypt_testdriver-argv.Po
> ./tests/unit_tests/openvpn/.deps/argv_testdriver-test_argv.Po
> ./tests/unit_tests/openvpn/.deps/argv_testdriver-mock_msg.Po
> ./tests/unit_tests/openvpn/.deps/argv_testdriver-platform.Po
> ./tests/unit_tests/openvpn/.deps/argv_testdriver-buffer.Po
> ./tests/unit_tests/openvpn/.deps/pkt_testdriver-argv.Po
> ./tests/unit_tests/openvpn/.deps/argv_testdriver-argv.Po
> ./src/openvpn/.deps/tls_crypt_testdriver-argv.Po
> ./src/openvpn/.deps/argv.Po
> ./src/openvpn/.deps/argv_testdriver-win32-util.Po
> ./src/openvpn/.deps/argv_testdriver-platform.Po
> ./src/openvpn/.deps/argv_testdriver-buffer.Po
> ./src/openvpn/.deps/pkt_testdriver-argv.Po
> ./src/openvpn/.deps/argv_testdriver-argv.Po
> ./src/openvpn/argv.o
>
> ... so it seems as if it did the "make depend" dance for the unit_tests,
> but then didn't compile anything for real.
>
>
> Did I apply stuff in the wrong order?  Do I need to more forcefully clean
> my build tree?
>

Ignore the previous email  -- (I behaved as if I can't read more than a
pageful).

Looks like unit-tests are not enabled during configure. For that, cmocka
should be available in the search path or set using CMOCKA_LIBS and
CMOCKA_INCLUDES.

It took a while for me to figure out how to cross-compile cmocka using
cmake and mingw on Linux. Finally what worked was pretty simple:

git clone https://github.com/clibs/cmocka.git
cd cmocka
checkout cmocka-1.1.5
mkdir build
cd build
cmake -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc
\
            -DCMAKE_SHARED_LINKER_FLAGS=-static-libgcc \
            -DCMAKE_INSTALL_PREFIX=$HOME/mingw-cmocka/ -S .. -B .
make install

Selva

--0000000000002b26e405f4609c20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 10, 2023 at 4:13 PM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Feb 07, 2023 at 07:59:25PM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Minor changes to the build system to include some<br>
&gt;=C2=A0 =C2=A0dependencies for Windows build<br>
&gt; <br>
&gt; - test_tls_crypt not built as it will pull in win32.c and<br>
&gt;=C2=A0 =C2=A0its dependencies<br>
&gt; <br>
&gt; - If cross-compiling, &quot;make check&quot; will only build the tests=
 but not<br>
&gt;=C2=A0 =C2=A0run any. Copy to Windows and run manually. Executables are=
 in<br>
&gt;=C2=A0 =C2=A0&lt;buid-dir&gt;/tests/unit_tests/openvpn/.libs/ and these=
 depend on<br>
&gt;=C2=A0 =C2=A0cmocka.dll in addition to openssl libs that some tests lin=
k to.<br>
<br>
I am something wrong, or I&#39;m missing some bits.<br>
<br>
I took this patch, on top of commit e80720ef939 (&quot;top of master as of<=
br>
now&quot;).=C2=A0 MinGW on Ubuntu.=C2=A0 &quot;autoreconf -iv&quot;, make c=
lean, then<br>
make &amp;&amp; make check.<br>
<br>
make check claims<br>
<br>
make[4]: Entering directory &#39;/home/gert/mingw/openvpn.git/tests&#39;<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
All 0 tests passed<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
... but it seems to have done... nothing?<br>
<br>
gert@...2713...:~/mingw/openvpn.git$ ls -l tests/unit_test/openvpn/.libs<br>
ls: cannot access &#39;tests/unit_test/openvpn/.libs&#39;: No such file or =
directory<br>
<br>
... given argv_testdriver exists, I should find &quot;something&quot; with =
argv*.o*<br>
here...<br>
<br>
gert@...2713...:~/mingw/openvpn.git$ find . -name &quot;*argv*o&quot;<br>
./tests/unit_tests/openvpn/.deps/argv_testdriver-mock_get_random.Po<br>
./tests/unit_tests/openvpn/.deps/tls_crypt_testdriver-argv.Po<br>
./tests/unit_tests/openvpn/.deps/argv_testdriver-test_argv.Po<br>
./tests/unit_tests/openvpn/.deps/argv_testdriver-mock_msg.Po<br>
./tests/unit_tests/openvpn/.deps/argv_testdriver-platform.Po<br>
./tests/unit_tests/openvpn/.deps/argv_testdriver-buffer.Po<br>
./tests/unit_tests/openvpn/.deps/pkt_testdriver-argv.Po<br>
./tests/unit_tests/openvpn/.deps/argv_testdriver-argv.Po<br>
./src/openvpn/.deps/tls_crypt_testdriver-argv.Po<br>
./src/openvpn/.deps/argv.Po<br>
./src/openvpn/.deps/argv_testdriver-win32-util.Po<br>
./src/openvpn/.deps/argv_testdriver-platform.Po<br>
./src/openvpn/.deps/argv_testdriver-buffer.Po<br>
./src/openvpn/.deps/pkt_testdriver-argv.Po<br>
./src/openvpn/.deps/argv_testdriver-argv.Po<br>
./src/openvpn/argv.o<br>
<br>
... so it seems as if it did the &quot;make depend&quot; dance for the unit=
_tests,<br>
but then didn&#39;t compile anything for real.<br>
<br>
<br>
Did I apply stuff in the wrong order?=C2=A0 Do I need to more forcefully cl=
ean<br>
my build tree?<br></blockquote><div><br></div><div>Ignore the previous emai=
l=C2=A0 -- (I behaved as if I can&#39;t read more than a pageful).=C2=A0</d=
iv><div><br></div><div>Looks like unit-tests are not enabled during configu=
re. For that, cmocka should be available in the search=C2=A0path or set usi=
ng CMOCKA_LIBS and CMOCKA_INCLUDES.</div><div><br></div><div>It took a whil=
e for me to figure out how to cross-compile cmocka using cmake and mingw on=
 Linux. Finally what worked was pretty simple:</div><div><br></div><div>git=
 clone=C2=A0<a href=3D"https://github.com/clibs/cmocka.git">https://github.=
com/clibs/cmocka.git</a></div><div>cd cmocka</div><div>checkout cmocka-1.1.=
5</div><div>mkdir build</div><div>cd build</div><div>cmake -DCMAKE_SYSTEM_N=
AME=3DWindows -DCMAKE_C_COMPILER=3Dx86_64-w64-mingw32-gcc \</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -DCMAKE_SHARED_LINKER_FLAGS=3D-stati=
c-libgcc \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -DCMAKE_INST=
ALL_PREFIX=3D$HOME/mingw-cmocka/ -S .. -B .<br></div><div>make install=C2=
=A0</div><div><br></div><div>Selva</div></div></div>

--0000000000002b26e405f4609c20--

