MIME-Version: 1.0
References: <20230206112218.51430-1-frank@...2641...>
 <20230207132026.41580-1-frank@...2641...>
In-Reply-To: <20230207132026.41580-1-frank@...2641...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Feb 2023 12:24:51 -0500
Message-ID: <CAKuzo_hYjUzDjYspqQx9fmvCmGEAu4kigFaTDvQoDMBdkeuCqg@...278...>
Content-Type: multipart/alternative; boundary="000000000000d3091405f41f6d9d"
Subject: Re: [Openvpn-devel] [PATCH v3] configure: enable DCO by default on
 FreeBSD/Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000d3091405f41f6d9d
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 7, 2023 at 8:22 AM Frank Lichtenheld <frank@...2641...>
wrote:

> Automatically disabled when
> - iproute2 is enabled
>   (Don't want to force people specifying --disable-dco explicitely)
> - libnv is missing on FreeBSD
>   (FreeBSD version too old anyway)
>
> Will still error out if libnl-genl is missing on Linux to
> make people aware of the new dependency.
>
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  configure.ac | 82 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 63 insertions(+), 19 deletions(-)
>
> v2: error out when libnl-genl is missing as discussed with ordex on
>     IRC.
>
> v3:
>  - improvements to the messages, suggested by Selva
>  - further improvements to the default specification, trying to make it
> clear
>  - if enabling iproute2, do not test for libnl-genl
>
>
> diff --git a/configure.ac b/configure.ac
> index 78c99740..ba33ccd8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -146,14 +146,27 @@ AC_ARG_ENABLE(
>
>  AC_ARG_ENABLE(
>         [dco],
> -       [AS_HELP_STRING([--enable-dco], [enable data channel offload
> support using the ovpn-dco kernel module (always enabled on Windows)
> @<:@default=no@:>@])],
> +       [AS_HELP_STRING([--disable-dco], [disable data channel offload
> support using the ovpn-dco kernel module @<:@default=yes@:>@ on
> Linux/FreeBSD, can't disable on Windows])],
>         ,
> -       [enable_dco="no"]
> +       [
> +               case "$host" in
> +                       *-*-linux*)
> +                               enable_dco="auto"
> +                       ;;
> +                       *-*-freebsd*)
> +                               enable_dco="auto"
> +                       ;;
> +                       *)
> +                               # note that this does not disable it for
> Windows
> +                               enable_dco="no"
> +                       ;;
> +               esac
> +       ]
>  )
>
>  AC_ARG_ENABLE(
>         [iproute2],
> -       [AS_HELP_STRING([--enable-iproute2], [enable support for iproute2
> @<:@default=no@:>@])],
> +       [AS_HELP_STRING([--enable-iproute2], [enable support for iproute2
> (disables DCO) @<:@default=no@:>@])],
>         ,
>         [enable_iproute2="no"]
>  )
> @@ -536,7 +549,7 @@ AC_CHECK_DECLS(
>         ,
>         [[${SOCKET_INCLUDES}]]
>  )
> -AC_CHECKING([anonymous union support])
> +AC_MSG_CHECKING([anonymous union support])
>  AC_COMPILE_IFELSE(
>         [AC_LANG_PROGRAM(
>                 [[
> @@ -771,28 +784,59 @@ PKG_CHECK_MODULES(
>  )
>
>
> -if test "$enable_dco" = "yes"; then
> -dnl
> -dnl Include generic netlink library used to talk to ovpn-dco
> -dnl
> +if test "$enable_dco" != "no"; then
> +       enable_dco_arg="$enable_dco"
> +       if test "${enable_iproute2}" = "yes"; then
> +               AC_MSG_WARN([DCO cannot be enabled when using iproute2])
> +               enable_dco="no"
> +       fi
>         case "$host" in
>                 *-*-linux*)
> -                       PKG_CHECK_MODULES([LIBNL_GENL],
> +                       if test "$enable_dco" = "no"; then
> +                               if test "$enable_dco_arg" = "auto"; then
> +                                       AC_MSG_WARN([DCO support
> disabled])



+                               else
> +                                       AC_MSG_ERROR([DCO support can't be
> enabled])
> +                               fi
> +                       else
> +                               dnl
> +                               dnl Include generic netlink library used
> to talk to ovpn-dco
> +                               dnl
> +                               PKG_CHECK_MODULES([LIBNL_GENL],
>                                           [libnl-genl-3.0 >= 3.4.0],
>                                           [have_libnl="yes"],
> -                                         [AC_MSG_ERROR([libnl-genl-3.0
> package not found or too old. Is the development package and pkg-config
> installed? Must be version 3.4.0 or newer])]
> -                       )
> -
> -                       CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
> -                       LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
> +                                         [
> +                                          AC_MSG_ERROR([libnl-genl-3.0
> package not found or too old. Is the development package and pkg-config
> installed? Must be version 3.4.0 or newer for DCO])
> +                                         ]
> +                               )
> +                               CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
> +                               LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
>
> -                       AC_DEFINE(ENABLE_DCO, 1, [Enable shared data
> channel offload])
> -                       AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
> +                               AC_DEFINE(ENABLE_DCO, 1, [Enable shared
> data channel offload])
> +                               AC_MSG_NOTICE([Enabled ovpn-dco support
> for Linux])
> +                       fi
>                         ;;
>                 *-*-freebsd*)
> -                       LIBS="${LIBS} -lnv"
> -                       AC_DEFINE(ENABLE_DCO, 1, [Enable data channel
> offload for FreeBSD])
> -                       AC_MSG_NOTICE([Enabled ovpn-dco support for
> FreeBSD])
> +                       AC_CHECK_LIB(
> +                               [nv],
> +                               [nvlist_create],
> +                               [
> +                                LIBS="${LIBS} -lnv"
> +                                AC_DEFINE(ENABLE_DCO, 1, [Enable data
> channel offload for FreeBSD])
> +                                AC_MSG_NOTICE([Enabled ovpn-dco support
> for FreeBSD])
> +                               ],
> +                               [
> +                                enable_dco="no"
> +                                AC_MSG_WARN([Name/Value pair library not
> found.])
> +                               ]
> +                       )
> +                       if test "$enable_dco" = "no"; then
> +                               if test "$enable_dco_arg" = "auto"; then
> +                                       AC_MSG_WARN([DCO support disabled])
> +                               else
> +                                       AC_MSG_ERROR([DCO support can't be
> enabled])
> +                               fi
> +                       fi
>                         ;;
>                 *-mingw*)
>                         AC_MSG_NOTICE([NOTE: --enable-dco ignored on
> Windows because it's always enabled])
>

Looks good to me.

Acked-by: Selva Nair <selva.nair@...277...>

Selva

--000000000000d3091405f41f6d9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwgRmVi
IDcsIDIwMjMgYXQgODoyMiBBTSBGcmFuayBMaWNodGVuaGVsZCAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmZyYW5rQC4uLjI2NDEuLi4iPmZyYW5rQC4uLjI2NDEuLi48L2E+Jmd0OyB3cm90ZTo8YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPkF1dG9tYXRpY2FsbHkgZGlzYWJsZWQgd2hlbjxicj4NCi0gaXByb3V0ZTIgaXMg
ZW5hYmxlZDxicj4NCsKgIChEb24mIzM5O3Qgd2FudCB0byBmb3JjZSBwZW9wbGUgc3BlY2lmeWlu
ZyAtLWRpc2FibGUtZGNvIGV4cGxpY2l0ZWx5KTxicj4NCi0gbGlibnYgaXMgbWlzc2luZyBvbiBG
cmVlQlNEPGJyPg0KwqAgKEZyZWVCU0QgdmVyc2lvbiB0b28gb2xkIGFueXdheSk8YnI+DQo8YnI+
DQpXaWxsIHN0aWxsIGVycm9yIG91dCBpZiBsaWJubC1nZW5sIGlzIG1pc3Npbmcgb24gTGludXgg
dG88YnI+DQptYWtlIHBlb3BsZSBhd2FyZSBvZiB0aGUgbmV3IGRlcGVuZGVuY3kuPGJyPg0KPGJy
Pg0KU2lnbmVkLW9mZi1ieTogRnJhbmsgTGljaHRlbmhlbGQgJmx0OzxhIGhyZWY9Im1haWx0bzpm
cmFua0AuLi4yNjQxLi4uIiB0YXJnZXQ9Il9ibGFuayI+ZnJhbmtALi4uMjY0MS4uLjwvYT4mZ3Q7
PGJyPg0KLS0tPGJyPg0KwqA8YSBocmVmPSJodHRwOi8vY29uZmlndXJlLmFjIiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5jb25maWd1cmUuYWM8L2E+IHwgODIgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLTxicj4NCsKgMSBmaWxlIGNo
YW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCnYyOiBl
cnJvciBvdXQgd2hlbiBsaWJubC1nZW5sIGlzIG1pc3NpbmcgYXMgZGlzY3Vzc2VkIHdpdGggb3Jk
ZXggb248YnI+DQrCoCDCoCBJUkMuPGJyPg0KPGJyPg0KdjM6PGJyPg0KwqAtIGltcHJvdmVtZW50
cyB0byB0aGUgbWVzc2FnZXMsIHN1Z2dlc3RlZCBieSBTZWx2YTxicj4NCsKgLSBmdXJ0aGVyIGlt
cHJvdmVtZW50cyB0byB0aGUgZGVmYXVsdCBzcGVjaWZpY2F0aW9uLCB0cnlpbmcgdG8gbWFrZSBp
dCBjbGVhcjxicj4NCsKgLSBpZiBlbmFibGluZyBpcHJvdXRlMiwgZG8gbm90IHRlc3QgZm9yIGxp
Ym5sLWdlbmw8YnI+DQo8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvPGEgaHJlZj0iaHR0cDovL2Nv
bmZpZ3VyZS5hYyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Y29uZmlndXJlLmFj
PC9hPiBiLzxhIGhyZWY9Imh0dHA6Ly9jb25maWd1cmUuYWMiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmNvbmZpZ3VyZS5hYzwvYT48YnI+DQppbmRleCA3OGM5OTc0MC4uYmEzM2Nj
ZDggMTAwNjQ0PGJyPg0KLS0tIGEvPGEgaHJlZj0iaHR0cDovL2NvbmZpZ3VyZS5hYyIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Y29uZmlndXJlLmFjPC9hPjxicj4NCisrKyBiLzxh
IGhyZWY9Imh0dHA6Ly9jb25maWd1cmUuYWMiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxh
bmsiPmNvbmZpZ3VyZS5hYzwvYT48YnI+DQpAQCAtMTQ2LDE0ICsxNDYsMjcgQEAgQUNfQVJHX0VO
QUJMRSg8YnI+DQo8YnI+DQrCoEFDX0FSR19FTkFCTEUoPGJyPg0KwqAgwqAgwqAgwqAgW2Rjb10s
PGJyPg0KLcKgIMKgIMKgIMKgW0FTX0hFTFBfU1RSSU5HKFstLWVuYWJsZS1kY29dLCBbZW5hYmxl
IGRhdGEgY2hhbm5lbCBvZmZsb2FkIHN1cHBvcnQgdXNpbmcgdGhlIG92cG4tZGNvIGtlcm5lbCBt
b2R1bGUgKGFsd2F5cyBlbmFibGVkIG9uIFdpbmRvd3MpIEAmbHQ7OkBkZWZhdWx0PW5vQDomZ3Q7
QF0pXSw8YnI+DQorwqAgwqAgwqAgwqBbQVNfSEVMUF9TVFJJTkcoWy0tZGlzYWJsZS1kY29dLCBb
ZGlzYWJsZSBkYXRhIGNoYW5uZWwgb2ZmbG9hZCBzdXBwb3J0IHVzaW5nIHRoZSBvdnBuLWRjbyBr
ZXJuZWwgbW9kdWxlIEAmbHQ7OkBkZWZhdWx0PXllc0A6Jmd0O0Agb24gTGludXgvRnJlZUJTRCwg
Y2FuJiMzOTt0IGRpc2FibGUgb24gV2luZG93c10pXSw8YnI+DQrCoCDCoCDCoCDCoCAsPGJyPg0K
LcKgIMKgIMKgIMKgW2VuYWJsZV9kY289JnF1b3Q7bm8mcXVvdDtdPGJyPg0KK8KgIMKgIMKgIMKg
Wzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgJnF1b3Q7JGhvc3QmcXVvdDsgaW48
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqLSotbGludXgqKTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVuYWJsZV9k
Y289JnF1b3Q7YXV0byZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi0qLWZyZWVi
c2QqKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGVuYWJsZV9kY289JnF1b3Q7YXV0byZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Kik8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAj
IG5vdGUgdGhhdCB0aGlzIGRvZXMgbm90IGRpc2FibGUgaXQgZm9yIFdpbmRvd3M8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbmFibGVfZGNvPSZx
dW90O25vJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOzs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlc2FjPGJyPg0KK8KgIMKgIMKgIMKgXTxicj4N
CsKgKTxicj4NCjxicj4NCsKgQUNfQVJHX0VOQUJMRSg8YnI+DQrCoCDCoCDCoCDCoCBbaXByb3V0
ZTJdLDxicj4NCi3CoCDCoCDCoCDCoFtBU19IRUxQX1NUUklORyhbLS1lbmFibGUtaXByb3V0ZTJd
LCBbZW5hYmxlIHN1cHBvcnQgZm9yIGlwcm91dGUyIEAmbHQ7OkBkZWZhdWx0PW5vQDomZ3Q7QF0p
XSw8YnI+DQorwqAgwqAgwqAgwqBbQVNfSEVMUF9TVFJJTkcoWy0tZW5hYmxlLWlwcm91dGUyXSwg
W2VuYWJsZSBzdXBwb3J0IGZvciBpcHJvdXRlMiAoZGlzYWJsZXMgRENPKSBAJmx0OzpAZGVmYXVs
dD1ub0A6Jmd0O0BdKV0sPGJyPg0KwqAgwqAgwqAgwqAgLDxicj4NCsKgIMKgIMKgIMKgIFtlbmFi
bGVfaXByb3V0ZTI9JnF1b3Q7bm8mcXVvdDtdPGJyPg0KwqApPGJyPg0KQEAgLTUzNiw3ICs1NDks
NyBAQCBBQ19DSEVDS19ERUNMUyg8YnI+DQrCoCDCoCDCoCDCoCAsPGJyPg0KwqAgwqAgwqAgwqAg
W1ske1NPQ0tFVF9JTkNMVURFU31dXTxicj4NCsKgKTxicj4NCi1BQ19DSEVDS0lORyhbYW5vbnlt
b3VzIHVuaW9uIHN1cHBvcnRdKTxicj4NCitBQ19NU0dfQ0hFQ0tJTkcoW2Fub255bW91cyB1bmlv
biBzdXBwb3J0XSk8YnI+DQrCoEFDX0NPTVBJTEVfSUZFTFNFKDxicj4NCsKgIMKgIMKgIMKgIFtB
Q19MQU5HX1BST0dSQU0oPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgW1s8YnI+DQpAQCAt
NzcxLDI4ICs3ODQsNTkgQEAgUEtHX0NIRUNLX01PRFVMRVMoPGJyPg0KwqApPGJyPg0KPGJyPg0K
PGJyPg0KLWlmIHRlc3QgJnF1b3Q7JGVuYWJsZV9kY28mcXVvdDsgPSAmcXVvdDt5ZXMmcXVvdDs7
IHRoZW48YnI+DQotZG5sPGJyPg0KLWRubCBJbmNsdWRlIGdlbmVyaWMgbmV0bGluayBsaWJyYXJ5
IHVzZWQgdG8gdGFsayB0byBvdnBuLWRjbzxicj4NCi1kbmw8YnI+DQoraWYgdGVzdCAmcXVvdDsk
ZW5hYmxlX2RjbyZxdW90OyAhPSAmcXVvdDtubyZxdW90OzsgdGhlbjxicj4NCivCoCDCoCDCoCDC
oGVuYWJsZV9kY29fYXJnPSZxdW90OyRlbmFibGVfZGNvJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKg
aWYgdGVzdCAmcXVvdDske2VuYWJsZV9pcHJvdXRlMn0mcXVvdDsgPSAmcXVvdDt5ZXMmcXVvdDs7
IHRoZW48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBQ19NU0dfV0FSTihbRENPIGNhbm5v
dCBiZSBlbmFibGVkIHdoZW4gdXNpbmcgaXByb3V0ZTJdKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGVuYWJsZV9kY289JnF1b3Q7bm8mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqBmaTxicj4N
CsKgIMKgIMKgIMKgIGNhc2UgJnF1b3Q7JGhvc3QmcXVvdDsgaW48YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAqLSotbGludXgqKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFBLR19DSEVDS19NT0RVTEVTKFtMSUJOTF9HRU5MXSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiB0ZXN0ICZxdW90OyRlbmFibGVfZGNvJnF1b3Q7ID0g
JnF1b3Q7bm8mcXVvdDs7IHRoZW48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZiB0ZXN0ICZxdW90OyRlbmFibGVfZGNvX2FyZyZxdW90OyA9ICZx
dW90O2F1dG8mcXVvdDs7IHRoZW48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBQ19NU0dfV0FSTihbRENPIHN1cHBvcnQgZGlz
YWJsZWRdKcKgwqA8L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPsKgPC9ibG9ja3F1b3RlPjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVsc2U8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBBQ19NU0dfRVJST1IoW0RDTyBzdXBwb3J0IGNhbiYjMzk7dCBiZSBlbmFibGVkXSk8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVsc2U8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbmw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbmwgSW5jbHVkZSBnZW5lcmljIG5l
dGxpbmsgbGlicmFyeSB1c2VkIHRvIHRhbGsgdG8gb3Zwbi1kY288YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbmw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQS0dfQ0hFQ0tfTU9EVUxFUyhbTElC
TkxfR0VOTF0sPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgW2xpYm5sLWdlbmwtMy4wICZndDs9IDMuNC4wXSw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBbaGF2ZV9saWJubD0mcXVvdDt5ZXMmcXVvdDtdLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFtBQ19NU0dfRVJS
T1IoW2xpYm5sLWdlbmwtMy4wIHBhY2thZ2Ugbm90IGZvdW5kIG9yIHRvbyBvbGQuIElzIHRoZSBk
ZXZlbG9wbWVudCBwYWNrYWdlIGFuZCBwa2ctY29uZmlnIGluc3RhbGxlZD8gTXVzdCBiZSB2ZXJz
aW9uIDMuNC4wIG9yIG5ld2VyXSldPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBD
RkxBR1M9JnF1b3Q7JHtDRkxBR1N9ICR7TElCTkxfR0VOTF9DRkxBR1N9JnF1b3Q7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTElCUz0mcXVvdDske0xJQlN9ICR7TElC
TkxfR0VOTF9MSUJTfSZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQUNfTVNHX0VSUk9S
KFtsaWJubC1nZW5sLTMuMCBwYWNrYWdlIG5vdCBmb3VuZCBvciB0b28gb2xkLiBJcyB0aGUgZGV2
ZWxvcG1lbnQgcGFja2FnZSBhbmQgcGtnLWNvbmZpZyBpbnN0YWxsZWQ/IE11c3QgYmUgdmVyc2lv
biAzLjQuMCBvciBuZXdlciBmb3IgRENPXSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBdPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENGTEFHUz0mcXVvdDske0NGTEFHU30g
JHtMSUJOTF9HRU5MX0NGTEFHU30mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMSUJTPSZxdW90OyR7TElCU30gJHtMSUJOTF9HRU5MX0xJ
QlN9JnF1b3Q7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
QUNfREVGSU5FKEVOQUJMRV9EQ08sIDEsIFtFbmFibGUgc2hhcmVkIGRhdGEgY2hhbm5lbCBvZmZs
b2FkXSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBQ19NU0dfTk9U
SUNFKFtFbmFibGVkIG92cG4tZGNvIHN1cHBvcnQgZm9yIExpbnV4XSk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBQ19ERUZJTkUoRU5BQkxFX0RD
TywgMSwgW0VuYWJsZSBzaGFyZWQgZGF0YSBjaGFubmVsIG9mZmxvYWRdKTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFDX01TR19OT1RJQ0UoW0Vu
YWJsZWQgb3Zwbi1kY28gc3VwcG9ydCBmb3IgTGludXhdKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGZpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgOzs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLSotZnJlZWJzZCopPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTElCUz0mcXVvdDske0xJQlN9IC1s
bnYmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBQ19ERUZJ
TkUoRU5BQkxFX0RDTywgMSwgW0VuYWJsZSBkYXRhIGNoYW5uZWwgb2ZmbG9hZCBmb3IgRnJlZUJT
RF0pPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQUNfTVNHX05PVElD
RShbRW5hYmxlZCBvdnBuLWRjbyBzdXBwb3J0IGZvciBGcmVlQlNEXSk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBQ19DSEVDS19MSUIoPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgW252XSw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBbbnZsaXN0X2NyZWF0ZV0sPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgWzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMSUJTPSZx
dW90OyR7TElCU30gLWxudiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBBQ19ERUZJTkUoRU5BQkxFX0RDTywgMSwgW0VuYWJsZSBkYXRh
IGNoYW5uZWwgb2ZmbG9hZCBmb3IgRnJlZUJTRF0pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFDX01TR19OT1RJQ0UoW0VuYWJsZWQgb3Zwbi1k
Y28gc3VwcG9ydCBmb3IgRnJlZUJTRF0pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgXSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBbPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGVuYWJsZV9kY289JnF1b3Q7bm8mcXVvdDs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQUNfTVNHX1dBUk4oW05h
bWUvVmFsdWUgcGFpciBsaWJyYXJ5IG5vdCBmb3VuZC5dKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgdGVzdCAmcXVvdDskZW5hYmxlX2RjbyZxdW90OyA9ICZxdW90O25vJnF1b3Q7OyB0aGVu
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
dGVzdCAmcXVvdDskZW5hYmxlX2Rjb19hcmcmcXVvdDsgPSAmcXVvdDthdXRvJnF1b3Q7OyB0aGVu
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgQUNfTVNHX1dBUk4oW0RDTyBzdXBwb3J0IGRpc2FibGVkXSk8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQUNf
TVNHX0VSUk9SKFtEQ08gc3VwcG9ydCBjYW4mIzM5O3QgYmUgZW5hYmxlZF0pPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmk8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDs7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi1taW5ndyop
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQUNfTVNHX05PVElDRShb
Tk9URTogLS1lbmFibGUtZGNvIGlnbm9yZWQgb24gV2luZG93cyBiZWNhdXNlIGl0JiMzOTtzIGFs
d2F5cyBlbmFibGVkXSk8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+TG9va3Mg
Z29vZCB0byBtZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFja2VkLWJ5OiBTZWx2YSBOYWly
ICZsdDs8YSBocmVmPSJtYWlsdG86c2VsdmEubmFpckAuLi4yNzcuLi4iIHRhcmdldD0iX2JsYW5r
Ij5zZWx2YS5uYWlyQC4uLjI3Ny4uLjwvYT4mZ3Q7PC9kaXY+PGJyPjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj5TZWx2YTwvZGl2PjwvZGl2Pg0K

--000000000000d3091405f41f6d9d--

